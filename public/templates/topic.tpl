<div class="topic">
<ol class="breadcrumb">
	<!-- BEGIN breadcrumbs -->
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb" <!-- IF @last -->class="active"<!-- ENDIF @last -->>
		<!-- IF !@last --><a href="{breadcrumbs.url}" itemprop="url"><!-- ENDIF !@last -->
			<span itemprop="title">
				{breadcrumbs.text}
				<!-- IF @last -->
				<!-- IF !feeds:disableRSS -->
				<!-- IF rssFeedUrl --><a target="_blank" href="{rssFeedUrl}"><i class="fa fa-rss-square"></i></a><!-- ENDIF rssFeedUrl --><!-- ENDIF !feeds:disableRSS -->
				<!-- ENDIF @last -->
			</span>
		<!-- IF !@last --></a><!-- ENDIF !@last -->
	</li>
	<!-- END breadcrumbs -->
</ol>

	<div component="topic/deleted/message" class="alert alert-warning<!-- IF !deleted --> hidden<!-- ENDIF !deleted -->">[[topic:deleted_message]]</div>

	<ul component="topic" id="post-container" class="posts" data-tid="{tid}">
		<!-- BEGIN posts -->
			<li component="post" class="post-row <!-- IF posts.deleted -->deleted<!-- ENDIF posts.deleted -->"data-pid="{posts.pid}" data-uid="{posts.uid}" data-username="{posts.user.username}" data-userslug="{posts.user.userslug}" data-index="{posts.index}" data-timestamp="{posts.timestamp}" data-votes="{posts.votes}" itemscope itemtype="http://schema.org/Comment">
				<a component="post/anchor" name="{posts.index}"></a>

				<meta itemprop="datePublished" content="{posts.relativeTime}">
				<meta itemprop="dateModified" content="{posts.relativeEditTime}">

				<div class="topic-item">
					<div class="topic-body">
						<div class="row">
							<div class="col-md-12">
								<div class="topic-profile-pic hidden-xs text-center">
									<a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
										<img src="{posts.user.picture}" alt="{posts.user.username}" class="profile-image user-img" title="{posts.user.username}">
									</a>
									<small class="username" title="{posts.user.username}"><a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">{posts.user.username}</a></small>

									<!-- IF posts.user.banned -->
									<div class="text-center">
										<span class="label label-danger">[[user:banned]]</span>
									</div>
									<!-- ENDIF posts.user.banned -->

<!-- IF posts.user.groups.length -->
<!-- BEGIN groups -->
<!-- IF ../selected -->
<!-- IF ../userTitleEnabled -->
<a href="{config.relative_path}/groups/{../slug}"><small class="label group-label inline-block" style="background-color: {../labelColor};"><!-- IF ../icon --><i class="fa {../icon}"></i> <!-- ENDIF ../icon -->{../userTitle}</small></a>
<!-- ENDIF ../userTitleEnabled -->
<!-- ENDIF ../selected -->
<!-- END groups -->
<!-- ENDIF posts.user.groups.length -->
								</div>
								<div class="topic-text">
									<!-- IF @first -->
									<h3 class="topic-title">
										<p component="post/header" class="topic-title" itemprop="name"><i class="fa fa-thumb-tack <!-- IF !pinned -->hidden<!-- ENDIF !pinned -->"></i> <i class="fa fa-lock <!-- IF !locked -->hidden<!-- ENDIF !locked -->"></i> <span component="topic/title">{title}</span></p>
										<hr>
									</h3>
									<!-- ENDIF @first -->
									<div component="post/content" class="post-content" itemprop="text">{posts.content}</div>
									<!-- IF posts.user.signature -->
									<div class="post-signature">{posts.user.signature}</div>
									<!-- ENDIF posts.user.signature -->
								</div>
							</div>
						</div>
					</div>
					<div class="topic-footer">
						<div class="row">
							<div class="">
								<small class="pull-right">
									<span>
										<!-- IF posts.user.userslug -->
										<i component="user/status" class="fa fa-circle status {posts.user.status}" title='[[global:{posts.user.status}]]'></i>
										<!-- ENDIF posts.user.userslug -->
										<span data-username="{posts.user.username}" data-uid="{posts.user.uid}">
											<!-- IF posts.user.userslug -->
											[[global:user_posted_ago, <strong><a href="{config.relative_path}/user/{posts.user.userslug}" itemprop="author">{posts.user.username}</a></strong>, <span class="timeago" title="{posts.relativeTime}"></span>]]
											<!-- ELSE -->
											[[global:guest_posted_ago, <span class="timeago" title="{posts.relativeTime}"></span>]]
											<!-- ENDIF posts.user.userslug -->
										</span>
									</span>


									<span component="post/editor" class="<!-- IF !posts.editor.username --> hidden<!-- ENDIF !posts.editor.username -->">, [[global:last_edited_by_ago, <strong><a href="{config.relative_path}/user/{posts.editor.userslug}">{posts.editor.username}</a></strong>, <span class="timeago" title="{posts.relativeEditTime}"></span>]]</span>

								</small>

								<div class="dropdown moderator-tools" component="post/tools">
									<a href="#" data-toggle="dropdown"><i class="fa fa-fw fa-gear"></i></a>
									<ul class="dropdown-menu" role="menu">
<!-- IF posts.display_moderator_tools -->
<li role="presentation" class="dropdown-header">[[topic:tools]]</li>
<li role="presentation">
	<a component="post/edit" role="menuitem" tabindex="-1" href="#">
		<span class="menu-icon"><i class="fa fa-pencil"></i></span> [[topic:edit]]
	</a>
</li>
<li role="presentation">
	<a component="post/delete" role="menuitem" tabindex="-1" href="#" class="<!-- IF posts.deleted -->hidden<!-- ENDIF posts.deleted -->">
		<div class="inline menu-icon"><i class="fa fa-trash-o"></i></div> <span>[[topic:delete]]</span>
	</a>
</li>
<li role="presentation">
	<a component="post/restore" role="menuitem" tabindex="-1" href="#" class="<!-- IF !posts.deleted -->hidden<!-- ENDIF !posts.deleted -->">
		<div class="inline menu-icon"><i class="fa fa-history"></i></div> <span>[[topic:restore]]</span>
	</a>
</li>
<li role="presentation">
	<a component="post/purge" role="menuitem" tabindex="-1" href="#" class="<!-- IF !posts.deleted -->hidden<!-- ENDIF !posts.deleted -->">
		<span class="menu-icon"><i class="fa fa-eraser"></i></span> [[topic:purge]]
	</a>
</li>
<!-- IF posts.display_move_tools -->
<li role="presentation">
	<a component="post/move" role="menuitem" tabindex="-1" href="#">
		<span class="menu-icon"><i class="fa fa-arrows"></i></span> [[topic:move]]
	</a>
</li>
<!-- ENDIF posts.display_move_tools -->
<li role="presentation" class="divider"></li>
<!-- ENDIF posts.display_moderator_tools -->

<li role="presentation">
	<a component="post/favourite" role="menuitem" tabindex="-1" href="#" data-favourited="{posts.favourited}">

		<span class="favourite-text">[[topic:favourite]]</span>
		<span component="post/favourite-count" class="favouriteCount" data-favourites="{posts.reputation}">{posts.reputation}</span>&nbsp;

		<i component="post/favourite/on" class="fa fa-heart <!-- IF !posts.favourited -->hidden<!-- ENDIF !posts.favourited -->"></i>
		<i component="post/favourite/off" class="fa fa-heart-o <!-- IF posts.favourited -->hidden<!-- ENDIF posts.favourited -->"></i>
	</a>
</li>

<!-- IF !config.disableSocialButtons -->
<li role="presentation" class="divider"></li>
<li role="presentation" class="dropdown-header">[[topic:share_this_post]]</li>
<li role="presentation">
	<a role="menuitem" class="facebook-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-facebook"></i></span> Facebook</a>
</li>
<li role="presentation">
	<a role="menuitem" class="twitter-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-twitter"></i></span> Twitter</a>
</li>
<li role="presentation">
	<a role="menuitem" class="google-share" tabindex="-1" href="#"><span class="menu-icon"><i class="fa fa-google-plus"></i></span> Google+</a>
</li>
<!-- ENDIF !config.disableSocialButtons -->

<li role="presentation" class="divider"></li>

<!-- IF !posts.selfPost -->
<li role="presentation">
	<a component="post/flag" role="menuitem" tabindex="-1" href="#">
		[[topic:flag_title]]
	</a>
</li>
<!-- ENDIF !posts.selfPost -->
									</ul>
								</div>

								<!-- IF !reputation:disabled -->
								&bull;
								<a component="post/upvote" href="#" class="upvote<!-- IF posts.upvoted --> upvoted<!-- ENDIF posts.upvoted -->">
									<i class="fa fa-chevron-up"></i>
								</a>
								<span component="post/vote-count" class="votes" data-votes="{posts.votes}">{posts.votes}</span>
								<!-- IF !downvote:disabled -->
								<a component="post/downvote" href="#" class="downvote<!-- IF posts.downvoted --> downvoted<!-- ENDIF posts.downvoted -->">
									<i class="fa fa-chevron-down"></i>
								</a>
								<!-- ENDIF !downvote:disabled -->
								<!-- ENDIF !reputation:disabled -->

								<!-- IF posts.user.custom_profile_info.length -->
									<!-- BEGIN custom_profile_info -->
									&bull; {posts.user.custom_profile_info.content}
									<!-- END custom_profile_info -->
								<!-- ENDIF posts.user.custom_profile_info.length -->
								<span class="post-tools">
									<!-- IF !posts.selfPost -->
									<!-- IF posts.user.userslug -->
									<!-- IF loggedIn -->
									<!-- IF !config.disableChat -->
									<button component="post/chat" class="btn btn-sm btn-link chat" type="button" title="[[topic:chat]]"><i class="fa fa-comment"></i><span class="hidden-xs-inline"> [[topic:chat]]</span></button>
									<!-- ENDIF !config.disableChat -->
									<!-- ENDIF loggedIn -->
									<!-- ENDIF posts.user.userslug -->
									<!-- ENDIF !posts.selfPost -->

									<button component="post/quote" class="btn btn-sm btn-link <!-- IF !privileges.topics:reply -->hidden<!--ENDIF !privileges.topics:reply -->" type="button" title="[[topic:quote]]"><i class="fa fa-quote-left"></i><span class="hidden-xs-inline"> [[topic:quote]]</span></button>
									<button component="post/reply" class="btn btn-sm btn-link <!-- IF !privileges.topics:reply -->hidden<!--ENDIF !privileges.topics:reply -->" type="button"><i class="fa fa-reply"></i><span class="hidden-xs-inline"> [[topic:reply]]</span></button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</li>

			<!-- IF !posts.index -->
			<div class="post-bar" data-index="{posts.index}">
<div class="inline-block">

	<span class="tags">
	<!-- BEGIN tags -->
	<a href="{config.relative_path}/tags/{tags.value}"><span class="tag-item" data-tag="{tags.value}" style="<!-- IF tags.color -->color: {tags.color};<!-- ENDIF tags.color --><!-- IF tags.bgColor -->background-color: {tags.bgColor};<!-- ENDIF tags.bgColor -->">{tags.value}</span><span class="tag-topic-count">{tags.score}</span></a>
	<!-- END tags -->
	</span>

	<!-- IF tags.length -->
	<span>|</span>
	<!-- ENDIF tags.length -->

	<small class="topic-stats">
		<span>[[global:posts]]</span>
		<strong><span component="topic/post-count" class="human-readable-number" title="{postcount}">{postcount}</span></strong> |
		<span>[[global:views]]</span>
		<strong><span class="human-readable-number" title="{viewcount}">{viewcount}</span></strong>
	</small>
	<span class="browsing-users hidden">
		&bull;
		<small><span>[[category:browsing]]</span></small>
		<div component="topic/browsing/list" class="thread_active_users active-users inline-block"></div>
		<small class="hidden">
			<i class="fa fa-users"></i> <span component="topic/browsing/count" class="user-count"></span>
		</small>
	</span>
</div>

<div class="topic-main-buttons pull-right inline-block">
	<div class="loading-indicator" done="0" style="display:none;">
		<span class="hidden-xs">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
	</div>



<a component="topic/reply" class="btn btn-primary <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->">[[topic:reply]]</a>

<!-- IF loggedIn -->

<!-- IF !privileges.topics:reply -->
<!-- IF locked -->
<a component="topic/reply/locked" class="btn btn-primary" disabled><i class="fa fa-lock"></i> [[topic:locked]]</a>
<!-- ENDIF locked -->
<!-- ENDIF !privileges.topics:reply -->

<!-- IF !locked -->
<a component="topic/reply/locked" class="btn btn-primary hidden" disabled><i class="fa fa-lock"></i> [[topic:locked]]</a>
<!-- ENDIF !locked -->

<!-- ELSE -->

<!-- IF !privileges.topics:reply -->
<a href="{config.relative_path}/login" class="btn btn-primary">[[topic:guest-login-reply]]</a>
<!-- ENDIF !privileges.topics:reply -->

<!-- ENDIF loggedIn -->




<!-- IF loggedIn -->
<div class="btn-group dropup" component="thread/sort">
	<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:sort_by]] <span class="caret"></span></button>
	<ul class="dropdown-menu pull-right">
		<li><a href="#" class="oldest_to_newest" data-sort="oldest_to_newest"><i class="fa fa-fw"></i> [[topic:oldest_to_newest]]</a></li>
		<li><a href="#" class="newest_to_oldest" data-sort="newest_to_oldest"><i class="fa fa-fw"></i> [[topic:newest_to_oldest]]</a></li>
		<li><a href="#" class="most_votes" data-sort="most_votes"><i class="fa fa-fw"></i> [[topic:most_votes]]</a></li>
	</ul>
</div>
<!-- ENDIF loggedIn -->

<!-- IF privileges.view_thread_tools -->
<div class="btn-group thread-tools dropup">
	<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:thread_tools.title]] <span class="caret"></span></button>
	<ul class="dropdown-menu pull-right">
		<!-- IF privileges.editable -->
		<li>
			<a component="topic/mark-unread-for-all" href="#">
				<i class="fa fa-fw fa-inbox"></i> [[topic:thread_tools.markAsUnreadForAll]]
			</a>
		</li>
		<li>
			<a component="topic/pin" href="#" class="<!-- IF pinned -->hidden<!-- ENDIF pinned -->">
				<i class="fa fa-fw fa-thumb-tack"></i> [[topic:thread_tools.pin]]
			</a>
		</li>
		<li>
			<a component="topic/unpin" href="#" class="<!-- IF !pinned -->hidden<!-- ENDIF !pinned -->">
				<i class="fa fa-fw fa-thumb-tack fa-rotate-90"></i> [[topic:thread_tools.unpin]]
			</a>
		</li>
		<li>
			<a component="topic/lock" href="#" class="<!-- IF locked -->hidden<!-- ENDIF locked -->">
				<i class="fa fa-fw fa-lock"></i> [[topic:thread_tools.lock]]
			</a>
		</li>
		<li>
			<a component="topic/unlock" href="#" class="<!-- IF !locked -->hidden<!-- ENDIF !locked -->">
				<i class="fa fa-fw fa-unlock"></i> [[topic:thread_tools.unlock]]
			</a>
		</li>
		<li class="divider"></li>

		<li>
			<a component="topic/move" href="#">
				<i class="fa fa-fw fa-arrows"></i> [[topic:thread_tools.move]]
			</a>
		</li>
		<li>
			<a component="topic/fork" href="#">
				<i class="fa fa-fw fa-code-fork"></i> [[topic:thread_tools.fork]]
			</a>
		</li>
		<li class="divider"></li>
		<!-- ENDIF privileges.editable -->

		<!-- IF privileges.deletable -->
		<li>
			<a component="topic/delete" href="#" class="<!-- IF deleted -->hidden<!-- ENDIF deleted -->">
				<i class="fa fa-fw fa-trash-o"></i> [[topic:thread_tools.delete]]
			</a>
		</li>
		<li>
			<a component="topic/restore" href="#" class="<!-- IF !deleted -->hidden<!-- ENDIF !deleted -->">
				<i class="fa fa-fw fa-history"></i> [[topic:thread_tools.restore]]
			</a>
		</li>
		<li>
			<a component="topic/purge" href="#" class="<!-- IF !deleted -->hidden<!-- ENDIF !deleted -->">
				<i class="fa fa-fw fa-eraser"></i> [[topic:thread_tools.purge]]
			</a>
		</li>

		<!-- BEGIN thread_tools -->
		<li>
			<a href="#" class="{thread_tools.class}"><i class="fa fa-fw {thread_tools.icon}"></i> {thread_tools.title}</a>
		</li>
		<!-- END thread_tools -->
		<!-- ENDIF privileges.deletable -->
	</ul>
</div>
<!-- ENDIF privileges.view_thread_tools -->
</div>
<div style="clear:both;"></div>
			</div>
			<!-- ENDIF !posts.index -->
		<!-- END posts -->
	</ul>

	<div class="post-bar col-xs-12 <!-- IF unreplied -->hidden<!-- ENDIF unreplied --> bottom-post-bar">
<div class="inline-block">

	<span class="tags">
	<!-- BEGIN tags -->
	<a href="{config.relative_path}/tags/{tags.value}"><span class="tag-item" data-tag="{tags.value}" style="<!-- IF tags.color -->color: {tags.color};<!-- ENDIF tags.color --><!-- IF tags.bgColor -->background-color: {tags.bgColor};<!-- ENDIF tags.bgColor -->">{tags.value}</span><span class="tag-topic-count">{tags.score}</span></a>
	<!-- END tags -->
	</span>

	<!-- IF tags.length -->
	<span>|</span>
	<!-- ENDIF tags.length -->

	<small class="topic-stats">
		<span>[[global:posts]]</span>
		<strong><span component="topic/post-count" class="human-readable-number" title="{postcount}">{postcount}</span></strong> |
		<span>[[global:views]]</span>
		<strong><span class="human-readable-number" title="{viewcount}">{viewcount}</span></strong>
	</small>
	<span class="browsing-users hidden">
		&bull;
		<small><span>[[category:browsing]]</span></small>
		<div component="topic/browsing/list" class="thread_active_users active-users inline-block"></div>
		<small class="hidden">
			<i class="fa fa-users"></i> <span component="topic/browsing/count" class="user-count"></span>
		</small>
	</span>
</div>

<div class="topic-main-buttons pull-right inline-block">
	<div class="loading-indicator" done="0" style="display:none;">
		<span class="hidden-xs">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
	</div>



<a component="topic/reply" class="btn btn-primary <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->">[[topic:reply]]</a>

<!-- IF loggedIn -->

<!-- IF !privileges.topics:reply -->
<!-- IF locked -->
<a component="topic/reply/locked" class="btn btn-primary" disabled><i class="fa fa-lock"></i> [[topic:locked]]</a>
<!-- ENDIF locked -->
<!-- ENDIF !privileges.topics:reply -->

<!-- IF !locked -->
<a component="topic/reply/locked" class="btn btn-primary hidden" disabled><i class="fa fa-lock"></i> [[topic:locked]]</a>
<!-- ENDIF !locked -->

<!-- ELSE -->

<!-- IF !privileges.topics:reply -->
<a href="{config.relative_path}/login" class="btn btn-primary">[[topic:guest-login-reply]]</a>
<!-- ENDIF !privileges.topics:reply -->

<!-- ENDIF loggedIn -->




<!-- IF loggedIn -->
<div class="btn-group dropup" component="thread/sort">
	<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:sort_by]] <span class="caret"></span></button>
	<ul class="dropdown-menu pull-right">
		<li><a href="#" class="oldest_to_newest" data-sort="oldest_to_newest"><i class="fa fa-fw"></i> [[topic:oldest_to_newest]]</a></li>
		<li><a href="#" class="newest_to_oldest" data-sort="newest_to_oldest"><i class="fa fa-fw"></i> [[topic:newest_to_oldest]]</a></li>
		<li><a href="#" class="most_votes" data-sort="most_votes"><i class="fa fa-fw"></i> [[topic:most_votes]]</a></li>
	</ul>
</div>
<!-- ENDIF loggedIn -->

<!-- IF privileges.view_thread_tools -->
<div class="btn-group thread-tools dropup">
	<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">[[topic:thread_tools.title]] <span class="caret"></span></button>
	<ul class="dropdown-menu pull-right">
		<!-- IF privileges.editable -->
		<li>
			<a component="topic/mark-unread-for-all" href="#">
				<i class="fa fa-fw fa-inbox"></i> [[topic:thread_tools.markAsUnreadForAll]]
			</a>
		</li>
		<li>
			<a component="topic/pin" href="#" class="<!-- IF pinned -->hidden<!-- ENDIF pinned -->">
				<i class="fa fa-fw fa-thumb-tack"></i> [[topic:thread_tools.pin]]
			</a>
		</li>
		<li>
			<a component="topic/unpin" href="#" class="<!-- IF !pinned -->hidden<!-- ENDIF !pinned -->">
				<i class="fa fa-fw fa-thumb-tack fa-rotate-90"></i> [[topic:thread_tools.unpin]]
			</a>
		</li>
		<li>
			<a component="topic/lock" href="#" class="<!-- IF locked -->hidden<!-- ENDIF locked -->">
				<i class="fa fa-fw fa-lock"></i> [[topic:thread_tools.lock]]
			</a>
		</li>
		<li>
			<a component="topic/unlock" href="#" class="<!-- IF !locked -->hidden<!-- ENDIF !locked -->">
				<i class="fa fa-fw fa-unlock"></i> [[topic:thread_tools.unlock]]
			</a>
		</li>
		<li class="divider"></li>

		<li>
			<a component="topic/move" href="#">
				<i class="fa fa-fw fa-arrows"></i> [[topic:thread_tools.move]]
			</a>
		</li>
		<li>
			<a component="topic/fork" href="#">
				<i class="fa fa-fw fa-code-fork"></i> [[topic:thread_tools.fork]]
			</a>
		</li>
		<li class="divider"></li>
		<!-- ENDIF privileges.editable -->

		<!-- IF privileges.deletable -->
		<li>
			<a component="topic/delete" href="#" class="<!-- IF deleted -->hidden<!-- ENDIF deleted -->">
				<i class="fa fa-fw fa-trash-o"></i> [[topic:thread_tools.delete]]
			</a>
		</li>
		<li>
			<a component="topic/restore" href="#" class="<!-- IF !deleted -->hidden<!-- ENDIF !deleted -->">
				<i class="fa fa-fw fa-history"></i> [[topic:thread_tools.restore]]
			</a>
		</li>
		<li>
			<a component="topic/purge" href="#" class="<!-- IF !deleted -->hidden<!-- ENDIF !deleted -->">
				<i class="fa fa-fw fa-eraser"></i> [[topic:thread_tools.purge]]
			</a>
		</li>

		<!-- BEGIN thread_tools -->
		<li>
			<a href="#" class="{thread_tools.class}"><i class="fa fa-fw {thread_tools.icon}"></i> {thread_tools.title}</a>
		</li>
		<!-- END thread_tools -->
		<!-- ENDIF privileges.deletable -->
	</ul>
</div>
<!-- ENDIF privileges.view_thread_tools -->
</div>
<div style="clear:both;"></div>
	</div>

	<!-- IF config.usePagination -->

<div class="text-center pagination-container<!-- IF !pagination.pages.length --> hidden<!-- ENDIF !pagination.pages.length -->">
	<ul class="pagination">
		<li class="previous pull-left<!-- IF !pagination.prev.active --> disabled<!-- ENDIF !pagination.prev.active -->">
			<a href="?{pagination.prev.qs}" data-page="{pagination.prev.page}"><i class="fa fa-chevron-left"></i> </a>
		</li>

		<!-- BEGIN pages -->
			<!-- IF pagination.pages.separator -->
			<li class="page select-page">
				<a href="#"><i class="fa fa-ellipsis-h"></i></a>
			</li>
			<!-- ELSE -->
			<li class="page<!-- IF pagination.pages.active --> active<!-- ENDIF pagination.pages.active -->" >
				<a href="?{pagination.pages.qs}" data-page="{pagination.pages.page}">{pagination.pages.page}</a>
			</li>
			<!-- ENDIF pagination.pages.separator -->
		<!-- END pages -->

		<li class="next pull-right<!-- IF !pagination.next.active --> disabled<!-- ENDIF !pagination.next.active -->">
			<a href="?{pagination.next.qs}" data-page="{pagination.next.page}"> <i class="fa fa-chevron-right"></i></a>
		</li>
	</ul>
</div>

	<!-- ENDIF config.usePagination -->

<div id="move_thread_modal" class="modal" tabindex="-1" role="dialog" aria-labelledby="Move Topic" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h3>[[topic:move_topic]]</h3>
			</div>
			<div class="modal-body">
				<p id="categories-loading"><i class="fa fa-spin fa-refresh"></i> [[topic:load_categories]]</p>
				<p>
					[[topic:disabled_categories_note]]
				</p>
				<div id="move-confirm" style="display: none;">
					<hr />
					<div class="alert alert-info">[[topic:topic_will_be_moved_to]] <strong><span id="confirm-category-name"></span></strong></div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="move_thread_cancel">[[global:buttons.close]]</button>
				<button type="button" class="btn btn-primary" id="move_thread_commit" disabled>[[topic:confirm_move]]</button>
			</div>
		</div>
	</div>
</div>
<div id="fork-thread-modal" class="hide" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" data-backdrop="none">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4>[[topic:fork_topic]]</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="title">Title</label>
					<input id="fork-title" type="text" class="form-control" placeholder="Enter new thread title"><br/>
					<label>[[topic:fork_topic_instruction]]</label> <br/>
					<span id="fork-pids"></span>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="fork_thread_cancel">[[global:buttons.close]]</button>
				<button type="button" class="btn btn-primary" id="fork_thread_commit" disabled>[[topic:confirm_fork]]</button>
			</div>
		</div>
	</div>
</div>
<div id="move-post-modal" class="hide" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" data-backdrop="none">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4>[[topic:move_post]]</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="topicId">Topic ID</label>
					<input id="topicId" type="text" class="form-control" placeholder="Enter topic ID"><br/>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="move_post_cancel">[[global:buttons.close]]</button>
				<button type="button" class="btn btn-primary" id="move_post_commit" disabled>[[topic:confirm_move]]</button>
			</div>
		</div>
	</div>
</div>
</div>

<!-- IF !config.usePagination -->
<noscript>

<div class="text-center pagination-container<!-- IF !pagination.pages.length --> hidden<!-- ENDIF !pagination.pages.length -->">
	<ul class="pagination">
		<li class="previous pull-left<!-- IF !pagination.prev.active --> disabled<!-- ENDIF !pagination.prev.active -->">
			<a href="?{pagination.prev.qs}" data-page="{pagination.prev.page}"><i class="fa fa-chevron-left"></i> </a>
		</li>

		<!-- BEGIN pages -->
			<!-- IF pagination.pages.separator -->
			<li class="page select-page">
				<a href="#"><i class="fa fa-ellipsis-h"></i></a>
			</li>
			<!-- ELSE -->
			<li class="page<!-- IF pagination.pages.active --> active<!-- ENDIF pagination.pages.active -->" >
				<a href="?{pagination.pages.qs}" data-page="{pagination.pages.page}">{pagination.pages.page}</a>
			</li>
			<!-- ENDIF pagination.pages.separator -->
		<!-- END pages -->

		<li class="next pull-right<!-- IF !pagination.next.active --> disabled<!-- ENDIF !pagination.next.active -->">
			<a href="?{pagination.next.qs}" data-page="{pagination.next.page}"> <i class="fa fa-chevron-right"></i></a>
		</li>
	</ul>
</div>

</noscript>
<!-- ENDIF !config.usePagination -->

