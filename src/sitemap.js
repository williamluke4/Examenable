'use strict';

var path = require('path'),
	async = require('async'),
	sm = require('sitemap'),
	url = require('url'),
	nconf = require('nconf'),
	db = require('./database'),
	categories = require('./categories'),
	topics = require('./topics'),
	privileges = require('./privileges'),
	meta = require('./meta'),
	utils = require('../public/src/utils');

var sitemap = {};

sitemap.render = function(callback) {
	if (sitemap.obj && sitemap.obj.cache.length) {
		return sitemap.obj.toXML(callback);
	}

	async.parallel([
		sitemap.getStaticUrls,
		sitemap.getDynamicUrls
	], function(err, urls) {
		if (err) {
			return callback(err);
		}

		urls = urls[0].concat(urls[1]);

		sitemap.obj = sm.createSitemap({
			hostname: nconf.get('url'),
			cacheTime: 1000 * 60 * 60,	// Cached for 1 hour
			urls: urls
		});

		sitemap.obj.toXML(callback);
	});
};

sitemap.getStaticUrls = function(callback) {
	callback(null, [{
		url: '',
		changefreq: 'weekly',
		priority: '0.6'
	}, {
		url: '/recent',
		changefreq: 'daily',
		priority: '0.4'
	}, {
		url: '/users',
		changefreq: 'daily',
		priority: '0.4'
	}]);
};

sitemap.getDynamicUrls = function(callback) {
	var returnUrls = [];

	async.parallel({
		categoryUrls: function(next) {
			var categoryUrls = [];
			categories.getCategoriesByPrivilege('categories:cid', 0, 'find', function(err, categoriesData) {
				if (err) {
					return next(err);
				}

				categoriesData.forEach(function(category) {
					if (category) {
						categoryUrls.push({
							url: '/category/' + category.slug,
							changefreq: 'weekly',
							priority: '0.4'
						});
					}
				});

				next(null, categoryUrls);
			});
		},
		topicUrls: function(next) {
			var topicUrls = [];

			async.waterfall([
				function(next) {
					db.getSortedSetRevRange('topics:recent', 0, parseInt(meta.config.sitemapTopics, 10) || -1, next);
				},
				function(tids, next) {
					privileges.topics.filterTids('read', tids, 0, next);
				},
				function(tids, next) {
					topics.getTopicsFields(tids, ['tid', 'title', 'slug', 'lastposttime'], next);
				}
			], function(err, topics) {
				if (err) {
					return next(err);
				}

				topics.forEach(function(topic) {
					if (topic) {
						topicUrls.push({
							url: '/topic/' + topic.slug,
							lastmodISO: utils.toISOString(topic.lastposttime),
							changefreq: 'daily',
							priority: '0.6'
						});
					}
				});

				next(null, topicUrls);
			});
		}
	}, function(err, data) {
		if (!err) {
			returnUrls = data.categoryUrls.concat(data.topicUrls);
		}

		callback(err, returnUrls);
	});
};


sitemap.clearCache = function() {
	if (sitemap.obj) {
		sitemap.obj.clearCache();
	}
};

module.exports = sitemap;
