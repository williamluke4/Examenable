<div class="recent-replies">
	<ul id="recent_posts" data-numposts="{numPosts}" data-cid="{cid}">
<!-- BEGIN posts -->
<li data-pid="{posts.pid}" class="clearfix">
	<a href="<!-- IF posts.user.userslug -->{relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
		<img title="{posts.user.username}" class="profile-image user-img" src="{posts.user.picture}" />
	</a>
	<div>
		{posts.content}
		<p class="fade-out"></p>
	</div>
	<span class="pull-right post-preview-footer">
		<span class="timeago" title="{posts.relativeTime}"></span> &bull;
		<a href="{relative_path}/topic/{posts.topic.slug}/{posts.index}">[[global:read_more]]</a>
	</span>
</li>
<!-- END posts -->
	</ul>
</div>

<script>
'use strict';
/* globals app, socket, translator, templates*/
$(document).ready(function() {
	var replies = $('#recent_posts');

	app.createUserTooltips();
	processHtml(replies);

	var recentPostsWidget = app.widgets.recentPosts;
	var numPosts = parseInt(replies.attr('data-numposts'), 10) || 4;

	if (!recentPostsWidget) {
		recentPostsWidget = {};
		recentPostsWidget.onNewPost = function(data) {
			var cid = replies.attr('data-cid');
			var recentPosts = $('#recent_posts');
			if (!recentPosts.length) {
				return;
			}

			if (cid && parseInt(cid, 10) !== parseInt(data.posts[0].topic.cid, 10)) {
				return;
			}

			parseAndTranslate(data.posts, function(html) {
				html.hide()
					.prependTo(recentPosts)
					.fadeIn();

				app.createUserTooltips();
				if (recentPosts.children().length > numPosts) {
					recentPosts.children().last().remove();
				}
			});
		};

		app.widgets.recentPosts = recentPostsWidget;
		socket.on('event:new_post', app.widgets.recentPosts.onNewPost);
	}

	function parseAndTranslate(posts, callback) {
		templates.parse('partials/posts', 'posts', {posts: posts}, function(html) {
			translator.translate(html, function(translatedHTML) {
				translatedHTML = $(translatedHTML);
				processHtml(translatedHTML);
				callback(translatedHTML);
			});
		});
	}

	function processHtml(html) {
		app.replaceSelfLinks(html.find('a'));

		html.find('img').addClass('img-responsive');
		html.find('span.timeago').timeago();
	}
});
</script>
