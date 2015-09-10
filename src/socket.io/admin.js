"use strict";

var	async = require('async'),
	winston = require('winston'),
	fs = require('fs'),
	path = require('path'),

	groups = require('../groups'),
	meta = require('../meta'),
	plugins = require('../plugins'),
	widgets = require('../widgets'),
	user = require('../user'),
	topics = require('../topics'),
	posts = require('../posts'),
	categories = require('../categories'),
	logger = require('../logger'),
	events = require('../events'),
	emailer = require('../emailer'),
	db = require('../database'),
	analytics = require('../analytics'),
	index = require('./index'),


	SocketAdmin = {
		user: require('./admin/user'),
		categories: require('./admin/categories'),
		groups: require('./admin/groups'),
		tags: require('./admin/tags'),
		rewards: require('./admin/rewards'),
		navigation: require('./admin/navigation'),
		themes: {},
		plugins: {},
		widgets: {},
		config: {},
		settings: {},
		email: {},
		analytics: {},
		logs: {}
	};

SocketAdmin.before = function(socket, method, next) {
	if (!socket.uid) {
		return;
	}
	user.isAdministrator(socket.uid, function(err, isAdmin) {
		if (!err && isAdmin) {
			next();
		} else {
			winston.warn('[socket.io] Call to admin method ( ' + method + ' ) blocked (accessed by uid ' + socket.uid + ')');
		}
	});
};

SocketAdmin.reload = function(socket, data, callback) {
	events.log({
		type: 'reload',
		uid: socket.uid,
		ip: socket.ip
	});
	if (process.send) {
		process.send({
			action: 'reload'
		});
	} else {
		meta.reload(callback);
	}
};

SocketAdmin.restart = function(socket, data, callback) {
	events.log({
		type: 'restart',
		uid: socket.uid,
		ip: socket.ip
	});
	meta.restart();
};

SocketAdmin.fireEvent = function(socket, data, callback) {
	index.server.sockets.emit(data.name, data.payload || {});
};

SocketAdmin.themes.getInstalled = function(socket, data, callback) {
	meta.themes.get(callback);
};

SocketAdmin.themes.set = function(socket, data, callback) {
	if(!data) {
		return callback(new Error('[[error:invalid-data]]'));
	}

	var wrappedCallback = function(err) {
		meta.themes.set(data, function() {
			callback();
		});
	};
	if (data.type === 'bootswatch') {
		wrappedCallback();
	} else {
		widgets.reset(wrappedCallback);
	}
};

SocketAdmin.themes.updateBranding = function(socket, data, callback) {
	meta.css.updateBranding();
};

SocketAdmin.plugins.toggleActive = function(socket, plugin_id, callback) {
	require('../posts/cache').reset();
	plugins.toggleActive(plugin_id, callback);
};

SocketAdmin.plugins.toggleInstall = function(socket, data, callback) {
	require('../posts/cache').reset();
	plugins.toggleInstall(data.id, data.version, callback);
};

SocketAdmin.plugins.getActive = function(socket, data, callback) {
	plugins.getActive(callback);
};

SocketAdmin.plugins.orderActivePlugins = function(socket, data, callback) {
	async.each(data, function(plugin, next) {
		if (plugin && plugin.name) {
			db.sortedSetAdd('plugins:active', plugin.order || 0, plugin.name, next);
		} else {
			next();
		}
	}, callback);
};

SocketAdmin.plugins.upgrade = function(socket, data, callback) {
	plugins.upgrade(data.id, data.version, callback);
};

SocketAdmin.widgets.set = function(socket, data, callback) {
	if(!data) {
		return callback(new Error('[[error:invalid-data]]'));
	}

	widgets.setArea(data, callback);
};

SocketAdmin.config.get = function(socket, data, callback) {
	meta.configs.list(callback);
};

SocketAdmin.config.set = function(socket, data, callback) {
	if(!data) {
		return callback(new Error('[[error:invalid-data]]'));
	}

	meta.configs.set(data.key, data.value, function(err) {
		if(err) {
			return callback(err);
		}

		callback(null);

		plugins.fireHook('action:config.set', {
			key: data.key,
			value: data.value
		});

		logger.monitorConfig({io: index.server}, data);
	});
};

SocketAdmin.config.setMultiple = function(socket, data, callback) {
	if(!data) {
		return callback(new Error('[[error:invalid-data]]'));
	}

	meta.configs.setMultiple(data, function(err) {
		if(err) {
			return callback(err);
		}

		callback();
		var setting;
		for(var field in data) {
			if (data.hasOwnProperty(field)) {
				setting = {
					key: field,
					value: data[field]
				};
				plugins.fireHook('action:config.set', setting);
				logger.monitorConfig({io: index.server}, setting);
			}
		}
	});
};

SocketAdmin.config.remove = function(socket, key) {
	meta.configs.remove(key);
};

SocketAdmin.settings.get = function(socket, data, callback) {
	meta.settings.get(data.hash, callback);
};

SocketAdmin.settings.set = function(socket, data, callback) {
	meta.settings.set(data.hash, data.values, callback);
};

SocketAdmin.settings.clearSitemapCache = function(socket, data, callback) {
	require('../sitemap').clearCache();
	callback();
};

SocketAdmin.email.test = function(socket, data, callback) {
	if (plugins.hasListeners('action:email.send')) {
		emailer.send('test', socket.uid, {
			subject: '[NodeBB] Test Email',
			site_title: meta.config.title || 'NodeBB'
		});
		callback();
	} else {
		callback(new Error('[[error:no-emailers-configured]]'));
	}
};

SocketAdmin.analytics.get = function(socket, data, callback) {
	data.units = 'hours'; // temp
	data.amount = 24;

	if (data && data.graph && data.units && data.amount) {
		if (data.graph === 'traffic') {
			async.parallel({
				uniqueVisitors: function(next) {
					getHourlyStatsForSet('analytics:uniquevisitors', data.amount, next);
				},
				pageviews: function(next) {
					getHourlyStatsForSet('analytics:pageviews', data.amount, next);
				},
				monthlyPageViews: function(next) {
					analytics.getMonthlyPageViews(next);
				}
			}, function(err, data) {
				data.pastDay = data.pageviews.reduce(function(a, b) {return parseInt(a, 10) + parseInt(b, 10);});
				data.pageviews[data.pageviews.length - 1] = parseInt(data.pageviews[data.pageviews.length - 1], 10) + analytics.getUnwrittenPageviews();
				callback(err, data);
			});
		}
	} else {
		callback(new Error('Invalid analytics call'));
	}
};

SocketAdmin.logs.get = function(socket, data, callback) {
	meta.logs.get(callback);
};

SocketAdmin.logs.clear = function(socket, data, callback) {
	meta.logs.clear(callback);
};

function getHourlyStatsForSet(set, hours, callback) {
	var hour = new Date(),
		terms = {},
		hoursArr = [];

	hour.setHours(hour.getHours(), 0, 0, 0);

	for (var i = 0, ii = hours; i < ii; i++) {
		hoursArr.push(hour.getTime());
		hour.setHours(hour.getHours() - 1, 0, 0, 0);
	}

	db.sortedSetScores(set, hoursArr, function(err, counts) {
		if (err) {
			return callback(err);
		}

		hoursArr.forEach(function(term, index) {
			terms[term] = counts[index] || 0;
		});

		var termsArr = [];

		hoursArr.reverse();
		hoursArr.forEach(function(hour, idx) {
			termsArr.push(terms[hour]);
		});

		callback(null, termsArr);
	});
}

SocketAdmin.getMoreEvents = function(socket, next, callback) {
	var start = parseInt(next, 10);
	if (start < 0) {
		return callback(null, {data: [], next: next});
	}
	var stop = start + 10;
	events.getEvents(start, stop, function(err, events) {
		if (err) {
			return callback(err);
		}
		callback(null, {events: events, next: stop + 1});
	});
};

SocketAdmin.deleteAllEvents = function(socket, data, callback) {
	events.deleteAll(callback);
};

SocketAdmin.dismissFlag = function(socket, pid, callback) {
	if (!pid) {
		return callback('[[error:invalid-data]]');
	}

	posts.dismissFlag(pid, callback);
};

SocketAdmin.dismissAllFlags = function(socket, data, callback) {
	posts.dismissAllFlags(callback);
};

SocketAdmin.getMoreFlags = function(socket, data, callback) {
	if (!data || !parseInt(data.after, 10)) {
		return callback('[[error:invalid-data]]');
	}
	var sortBy = data.sortBy || 'count';
	var byUsername = data.byUsername ||  '';
	var start = parseInt(data.after, 10);
	var stop = start + 19;
	if (byUsername) {
		posts.getUserFlags(byUsername, sortBy, socket.uid, start, stop, function(err, posts) {
			callback(err, {posts: posts, next: stop + 1});
		});
	} else {
		var set = sortBy === 'count' ? 'posts:flags:count' : 'posts:flagged';
		posts.getFlags(set, socket.uid, start, stop, function(err, posts) {
			callback(err, {posts: posts, next: stop + 1});
		});
	}
};

SocketAdmin.takeHeapSnapshot = function(socket, data, callback) {
	require('heapdump').writeSnapshot(callback);
};

module.exports = SocketAdmin;
