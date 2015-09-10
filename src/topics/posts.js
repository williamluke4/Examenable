

'use strict';

var async = require('async'),
	winston = require('winston'),
	_ = require('underscore'),
	validator = require('validator'),

	db = require('../database'),
	user = require('../user'),
	favourites = require('../favourites'),
	posts = require('../posts'),
	privileges = require('../privileges'),
	meta = require('../meta');

module.exports = function(Topics) {

	Topics.onNewPostMade = function(postData, callback) {
		async.parallel([
			function(next) {
				Topics.increasePostCount(postData.tid, next);
			},
			function(next) {
				Topics.updateTimestamp(postData.tid, postData.timestamp, next);
			},
			function(next) {
				Topics.addPostToTopic(postData.tid, postData.pid, postData.timestamp, 0, next);
			}
		], callback);
	};

	Topics.getTopicPosts = function(tid, set, start, stop, uid, reverse, callback) {
		callback = callback || function() {};
		async.parallel({
			posts: function(next) {
				posts.getPostsFromSet(set, start, stop, uid, reverse, next);
			},
			postCount: function(next) {
				Topics.getTopicField(tid, 'postcount', next);
			}
		}, function(err, results) {
			if (err) {
				return callback(err);
			}

			var indices = Topics.calculatePostIndices(start, stop, results.postCount, reverse);
			results.posts.forEach(function(post, index) {
				if (post) {
					post.index = indices[index];
				}
			});

			Topics.addPostData(results.posts, uid, callback);
		});
	};

	Topics.addPostData = function(postData, uid, callback) {
		if (!Array.isArray(postData) || !postData.length) {
			return callback(null, []);
		}
		var pids = postData.map(function(post) {
			return post && post.pid;
		});

		if (!Array.isArray(pids) || !pids.length) {
			return callback(null, []);
		}

		async.parallel({
			favourites: function(next) {
				favourites.getFavouritesByPostIDs(pids, uid, next);
			},
			voteData: function(next) {
				favourites.getVoteStatusByPostIDs(pids, uid, next);
			},
			userData: function(next) {
				var uids = [];

				for(var i=0; i<postData.length; ++i) {
					if (postData[i] && uids.indexOf(postData[i].uid) === -1) {
						uids.push(postData[i].uid);
					}
				}

				posts.getUserInfoForPosts(uids, uid, function(err, users) {
					if (err) {
						return next(err);
					}

					var userData = {};
					users.forEach(function(user, index) {
						userData[uids[index]] = user;
					});

					next(null, userData);
				});
			},
			editors: function(next) {
				var editors = [];
				for(var i=0; i<postData.length; ++i) {
					if (postData[i] && postData[i].editor && editors.indexOf(postData[i].editor) === -1) {
						editors.push(postData[i].editor);
					}
				}

				user.getMultipleUserFields(editors, ['uid', 'username', 'userslug'], function(err, editors) {
					if (err) {
						return next(err);
					}
					var editorData = {};
					editors.forEach(function(editor) {
						editorData[editor.uid] = editor;
					});
					next(null, editorData);
				});
			},
			privileges: function(next) {
				privileges.posts.get(pids, uid, next);
			}
		}, function(err, results) {
			if (err) {
				return callback(err);
			}

			postData.forEach(function(postObj, i) {
				if (postObj) {
					postObj.deleted = parseInt(postObj.deleted, 10) === 1;
					postObj.user = parseInt(postObj.uid, 10) ? results.userData[postObj.uid] : _.clone(results.userData[postObj.uid]);
					postObj.editor = postObj.editor ? results.editors[postObj.editor] : null;
					postObj.favourited = results.favourites[i];
					postObj.upvoted = results.voteData.upvotes[i];
					postObj.downvoted = results.voteData.downvotes[i];
					postObj.votes = postObj.votes || 0;
					postObj.display_moderator_tools = results.privileges[i].editable;
					postObj.display_move_tools = results.privileges[i].move && postObj.index !== 0;
					postObj.selfPost = parseInt(uid, 10) === parseInt(postObj.uid, 10);

					if(postObj.deleted && !results.privileges[i].view_deleted) {
						postObj.content = '[[topic:post_is_deleted]]';
					}

					// Username override for guests, if enabled
					if (parseInt(meta.config.allowGuestHandles, 10) === 1 && parseInt(postObj.uid, 10) === 0 && postObj.handle) {
						postObj.user.username = validator.escape(postObj.handle);
					}
				}
			});

			callback(null, postData);
		});
	};

	Topics.calculatePostIndices = function(start, stop, postCount, reverse) {
		var indices = [];
		var count = stop - start + 1;
		for(var i=0; i<count; ++i) {
			if (reverse) {
				indices.push(postCount - (start + i + 1));
			} else {
				indices.push(start + i + 1);
			}
		}
		return indices;
	};

	Topics.getLatestUndeletedPid = function(tid, callback) {
		async.waterfall([
			function(next) {
				Topics.getLatestUndeletedReply(tid, next);
			},
			function(pid, next) {
				if (parseInt(pid, 10)) {
					return callback(null, pid.toString());
				}
				Topics.getTopicField(tid, 'mainPid', next);
			},
			function(mainPid, next) {
				posts.getPostFields(mainPid, ['pid', 'deleted'], next);
			},
			function(mainPost, next) {
				next(null, parseInt(mainPost.pid, 10) && parseInt(mainPost.deleted, 10) !== 1 ? mainPost.pid.toString() : null);
			}
		], callback);
	};

	Topics.getLatestUndeletedReply = function(tid, callback) {
		var isDeleted = false;
		var done = false;
		var latestPid = null;
		var index = 0;
		async.doWhilst(
			function(next) {
				db.getSortedSetRevRange('tid:' + tid + ':posts', index, index, function(err, pids) {
					if (err) {
						return next(err);
					}

					if (!Array.isArray(pids) || !pids.length) {
						done = true;
						return next();
					}

					posts.getPostField(pids[0], 'deleted', function(err, deleted) {
						if (err) {
							return next(err);
						}

						isDeleted = parseInt(deleted, 10) === 1;
						if (!isDeleted) {
							latestPid = pids[0];
						}
						++index;
						next();
					});
				});
			},
			function() {
				return isDeleted && !done;
			},
			function(err) {
				callback(err, latestPid);
			}
		);
	};

	Topics.addPostToTopic = function(tid, pid, timestamp, votes, callback) {
		Topics.getTopicField(tid, 'mainPid', function(err, mainPid) {
			if (err) {
				return callback(err);
			}
			if (!parseInt(mainPid, 10)) {
				Topics.setTopicField(tid, 'mainPid', pid, callback);
			} else {
				async.parallel([
					function(next) {
						db.sortedSetAdd('tid:' + tid + ':posts', timestamp, pid, next);
					},
					function(next) {
						db.sortedSetAdd('tid:' + tid + ':posts:votes', votes, pid, next);
					}
				], function(err) {
					if (err) {
						return callback(err);
					}
					Topics.updateTeaser(tid, callback);
				});
			}
		});
	};

	Topics.removePostFromTopic = function(tid, pid, callback) {
		db.sortedSetsRemove(['tid:' + tid + ':posts', 'tid:' + tid + ':posts:votes'], pid, function(err) {
			if (err) {
				return callback(err);
			}
			Topics.updateTeaser(tid, callback);
		});
	};

	Topics.getPids = function(tid, callback) {
		async.parallel({
			mainPid: function(next) {
				Topics.getTopicField(tid, 'mainPid', next);
			},
			pids: function(next) {
				db.getSortedSetRange('tid:' + tid + ':posts', 0, -1, next);
			}
		}, function(err, results) {
			if (err) {
				return callback(err);
			}
			if (results.mainPid) {
				results.pids = [results.mainPid].concat(results.pids);
			}
			callback(null, results.pids);
		});
	};

	Topics.increasePostCount = function(tid, callback) {
		incrementFieldAndUpdateSortedSet(tid, 'postcount', 1, 'topics:posts', callback);
	};

	Topics.decreasePostCount = function(tid, callback) {
		incrementFieldAndUpdateSortedSet(tid, 'postcount', -1, 'topics:posts', callback);
	};

	Topics.increaseViewCount = function(tid, callback) {
		incrementFieldAndUpdateSortedSet(tid, 'viewcount', 1, 'topics:views', callback);
	};

	function incrementFieldAndUpdateSortedSet(tid, field, by, set, callback) {
		callback = callback || function() {};
		db.incrObjectFieldBy('topic:' + tid, field, by, function(err, value) {
			if (err) {
				return callback(err);
			}
			db.sortedSetAdd(set, value, tid, callback);
		});
	}

	Topics.getTitleByPid = function(pid, callback) {
		Topics.getTopicFieldByPid('title', pid, callback);
	};

	Topics.getTopicFieldByPid = function(field, pid, callback) {
		posts.getPostField(pid, 'tid', function(err, tid) {
			if (err) {
				return callback(err);
			}
			Topics.getTopicField(tid, field, callback);
		});
	};

	Topics.getTopicDataByPid = function(pid, callback) {
		posts.getPostField(pid, 'tid', function(err, tid) {
			if (err) {
				return callback(err);
			}
			Topics.getTopicData(tid, callback);
		});
	};

	Topics.getPostCount = function(tid, callback) {
		db.getObjectField('topic:' + tid, 'postcount', callback);
	};

};
