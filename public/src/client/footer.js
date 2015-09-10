"use strict";
/*globals define, app, socket*/

define('forum/footer', ['notifications', 'chat', 'components', 'translator'], function(Notifications, Chat, components, translator) {

	Notifications.prepareDOM();
	Chat.prepareDOM();
	translator.prepareDOM();

	function updateUnreadTopicCount(err, count) {
		if (err) {
			return console.warn('Error updating unread count', err);
		}

		$('#unread-count i')
			.toggleClass('unread-count', count > 0)
			.attr('data-content', count > 20 ? '20+' : count);
	}

	function updateUnreadChatCount(err, count) {
		if (err) {
			return console.warn('Error updating unread count', err);
		}

		components.get('chat/icon')
			.toggleClass('unread-count', count > 0)
			.attr('data-content', count > 20 ? '20+' : count);
	}

	function initUnreadTopics() {
		var unreadTopics = {};

		function onNewPost(data) {
			if (data && data.posts && data.posts.length) {
				var post = data.posts[0];

				if (parseInt(post.uid, 10) !== parseInt(app.user.uid, 10) && !unreadTopics[post.topic.tid]) {
					increaseUnreadCount();
					markTopicsUnread(post.topic.tid);
					unreadTopics[post.topic.tid] = true;
				}
			}
		}

		function increaseUnreadCount() {
			var count = parseInt($('#unread-count i').attr('data-content'), 10) + 1;
			updateUnreadTopicCount(null, count);
		}

		function markTopicsUnread(tid) {
			$('[data-tid="' + tid + '"]').addClass('unread');
		}

		$(window).on('action:ajaxify.end', function(ev, data) {
			var tid = data.url.match(/^topic\/(\d+)/);

			if (tid && tid[1]) {
				delete unreadTopics[tid[1]];
			}
		});

		socket.on('event:new_post', onNewPost);
	}

	socket.on('event:unread.updateCount', updateUnreadTopicCount);
	socket.emit('user.getUnreadCount', updateUnreadTopicCount);

	socket.on('event:unread.updateChatCount', updateUnreadChatCount);
	socket.emit('user.getUnreadChatCount', updateUnreadChatCount);

	initUnreadTopics();
});
