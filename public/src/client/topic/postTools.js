'use strict';

/* globals define, app, ajaxify, bootbox, socket, templates, utils */

define('forum/topic/postTools', ['share', 'navigator', 'components', 'translator'], function(share, navigator, components, translator) {

	var PostTools = {},
		topicName;

	PostTools.init = function(tid) {
		topicName = ajaxify.data.title;

		addPostHandlers(tid);

		share.addShareHandlers(topicName);

		addVoteHandler();
	};

	PostTools.toggle = function(pid, isDeleted) {
		var postEl = components.get('post', 'pid', pid);

		postEl.find('[component="post/quote"], [component="post/favourite"], [component="post/reply"], [component="post/flag"], [component="user/chat"]')
			.toggleClass('hidden', isDeleted);

		postEl.find('[component="post/delete"]').toggleClass('hidden', isDeleted);
		postEl.find('[component="post/restore"]').toggleClass('hidden', !isDeleted);
		postEl.find('[component="post/purge"]').toggleClass('hidden', !isDeleted);
	};

	PostTools.updatePostCount = function() {
		socket.emit('topics.postcount', ajaxify.data.tid, function(err, postCount) {
			if (!err) {
				var postCountEl = components.get('topic/post-count');
				postCountEl.html(postCount).attr('title', postCount);
				utils.makeNumbersHumanReadable(postCountEl);
				navigator.setCount(postCount);
			}
		});
	};

	function addVoteHandler() {
		components.get('topic').on('mouseenter', '[data-pid] .votes', function() {
			loadDataAndCreateTooltip($(this));
		});
	}

	function loadDataAndCreateTooltip(el) {
		var pid = el.parents('[data-pid]').attr('data-pid');
		socket.emit('posts.getUpvoters', [pid], function(err, data) {
			if (!err && data.length) {
				createTooltip(el, data[0]);
			}
		});
	}

	function createTooltip(el, data) {
		var usernames = data.usernames;
		if (!usernames.length) {
			return;
		}
		if (usernames.length + data.otherCount > 6) {
			usernames = usernames.join(', ').replace(/,/g, '|');
			translator.translate('[[topic:users_and_others, ' + usernames + ', ' + data.otherCount + ']]', function(translated) {
				translated = translated.replace(/\|/g, ',');
				el.attr('title', translated).tooltip('destroy').tooltip('show');
			});
		} else {
			usernames = usernames.join(', ');
			el.attr('title', usernames).tooltip('destroy').tooltip('show');
		}
	}

	function addPostHandlers(tid) {
		var postContainer = components.get('topic');

		postContainer.on('click', '[component="post/quote"]', function() {
			onQuoteClicked($(this), tid, topicName);
		});

		postContainer.on('click', '[component="post/reply"]', function() {
			onReplyClicked($(this), tid, topicName);
		});

		components.get('topic/reply').on('click', function() {
			onReplyClicked($(this), tid, topicName);
		});

		postContainer.on('click', '[component="post/favourite"]', function() {
			favouritePost($(this), getData($(this), 'data-pid'));
		});

		postContainer.on('click', '[component="post/upvote"]', function() {
			return toggleVote($(this), '.upvoted', 'posts.upvote');
		});

		postContainer.on('click', '[component="post/downvote"]', function() {
			return toggleVote($(this), '.downvoted', 'posts.downvote');
		});

		postContainer.on('click', '[component="post/vote-count"]', function() {
			showVotes(getData($(this), 'data-pid'));
		});

		postContainer.on('click', '[component="post/flag"]', function() {
			flagPost(getData($(this), 'data-pid'));
		});

		postContainer.on('click', '[component="post/edit"]', function(e) {
			var btn = $(this);
			$(window).trigger('action:composer.post.edit', {
				pid: getData(btn, 'data-pid')
			});
		});

		postContainer.on('click', '[component="post/delete"]', function(e) {
			togglePostDelete($(this), tid);
		});

		postContainer.on('click', '[component="post/restore"]', function(e) {
			togglePostDelete($(this), tid);
		});

		postContainer.on('click', '[component="post/purge"]', function(e) {
			purgePost($(this), tid);
		});

		postContainer.on('click', '[component="post/move"]', function(e) {
			openMovePostModal($(this));
		});

		postContainer.on('click', '[component="post/chat"]', function(e) {
			openChat($(this));
		});
	}

	function onReplyClicked(button, tid, topicName) {
		var selectionText = '',
			selection = window.getSelection ? window.getSelection() : document.selection.createRange();

		if ($(selection.baseNode).parents('[component="post/content"]').length > 0) {
			selectionText = selection.toString();
		}

		var username = getUserName(selectionText ? $(selection.baseNode) : button);
		if (getData(button, 'data-uid') === '0') {
			username = '';
		}
		if (selectionText.length) {
			$(window).trigger('action:composer.addQuote', {
				tid: tid,
				slug: ajaxify.data.slug,
				index: getData(button, 'data-index'),
				pid: getData(button, 'data-pid'),
				topicName: topicName,
				username: username,
				text: selectionText
			});
		} else {
			$(window).trigger('action:composer.post.new', {
				tid: tid,
				pid: getData(button, 'data-pid'),
				topicName: topicName,
				text: username ? username + ' ' : ''
			});
		}
	}

	function onQuoteClicked(button, tid, topicName) {
		var username = getUserName(button),
			pid = getData(button, 'data-pid');

		socket.emit('posts.getRawPost', pid, function(err, post) {
			if(err) {
				return app.alertError(err.message);
			}

			$(window).trigger('action:composer.addQuote', {
				tid: tid,
				slug: ajaxify.data.slug,
				index: getData(button, 'data-index'),
				pid: pid,
				username: username,
				topicName: topicName,
				text: post
			});
		});
	}

	function favouritePost(button, pid) {
		var method = button.attr('data-favourited') === 'false' ? 'posts.favourite' : 'posts.unfavourite';

		socket.emit(method, {
			pid: pid,
			room_id: app.currentRoom
		}, function(err) {
			if (err) {
				app.alertError(err.message);
			}
		});

		return false;
	}

	function toggleVote(button, className, method) {
		var post = button.parents('[data-pid]'),
			currentState = post.find(className).length;

		socket.emit(currentState ? 'posts.unvote' : method , {
			pid: post.attr('data-pid'),
			room_id: app.currentRoom
		}, function(err) {
			if (err) {
				app.alertError(err.message);
			}
		});

		return false;
	}

	function showVotes(pid) {
		socket.emit('posts.getVoters', {pid: pid, cid: ajaxify.data.cid}, function(err, data) {
			if (err) {
				return app.alertError(err.message);
			}

			templates.parse('partials/modals/votes_modal', data, function(html) {
				var dialog = bootbox.dialog({
					title: 'Voters',
					message: html,
					className: 'vote-modal',
					show: true
				});

				dialog.on('click', function() {
					dialog.modal('hide');
				});
			});
		});
	}

	function getData(button, data) {
		return button.parents('[data-pid]').attr(data);
	}

	function getUserName(button) {
		var username = '',
			post = button.parents('[data-pid]');

		if (post.length) {
			username = post.attr('data-username').replace(/\s/g, '-');
		}
		if (post.length && post.attr('data-uid') !== '0') {
			username = '@' + username;
		}

		return username;
	}

	function togglePostDelete(button, tid) {
		var pid = getData(button, 'data-pid'),
			postEl = components.get('post', 'pid', pid),
			action = !postEl.hasClass('deleted') ? 'delete' : 'restore';

		postAction(action, pid, tid);
	}

	function purgePost(button, tid) {
		postAction('purge', getData(button, 'data-pid'), tid);
	}

	function postAction(action, pid, tid) {
		translator.translate('[[topic:post_' + action + '_confirm]]', function(msg) {
			bootbox.confirm(msg, function(confirm) {
				if (!confirm) {
					return;
				}

				socket.emit('posts.' + action, {
					pid: pid,
					tid: tid
				}, function(err) {
					if (err) {
						app.alertError(err.message);
					}
				});
			});
		});
	}

	function openMovePostModal(button) {
		var moveModal = $('#move-post-modal'),
			moveBtn = moveModal.find('#move_post_commit'),
			topicId = moveModal.find('#topicId');

		showMoveModal();

		moveModal.find('.close,#move_post_cancel').on('click', function() {
			moveModal.addClass('hide');
		});

		topicId.on('change', function() {
			if(topicId.val().length) {
				moveBtn.removeAttr('disabled');
			} else {
				moveBtn.attr('disabled', true);
			}
		});

		moveBtn.on('click', function() {
			movePost(button.parents('[data-pid]'), getData(button, 'data-pid'), topicId.val());
		});
	}

	function showMoveModal() {
		$('#move-post-modal').removeClass('hide')
			.css("position", "fixed")
			.css("left", Math.max(0, (($(window).width() - $($('#move-post-modal')).outerWidth()) / 2) + $(window).scrollLeft()) + "px")
			.css("top", "0px")
			.css("z-index", "2000");
	}

	function movePost(post, pid, tid) {
		socket.emit('topics.movePost', {pid: pid, tid: tid}, function(err) {
			$('#move-post-modal').addClass('hide');

			if (err) {
				$('#topicId').val('');
				return app.alertError(err.message);
			}

			post.fadeOut(500, function() {
				post.remove();
			});

			$('#topicId').val('');

			app.alertSuccess('[[topic:post_moved]]');
		});
	}

	function flagPost(pid) {
		translator.translate('[[topic:flag_confirm]]', function(message) {
			bootbox.confirm(message, function(confirm) {
				if (!confirm) {
					return;
				}
				socket.emit('posts.flag', pid, function(err) {
					if (err) {
						return app.alertError(err.message);
					}

					app.alertSuccess('[[topic:flag_success]]');
				});
			});
		});
	}

	function openChat(button) {
		var post = button.parents('[data-pid]');

		app.openChat(post.attr('data-username'), post.attr('data-uid'));
		button.parents('.btn-group').find('.dropdown-toggle').click();
		return false;
	}

	return PostTools;
});
