<input type="hidden" template-variable="category_id" value="{cid}" />
<input type="hidden" template-variable="category_name" value="{name}" />
<input type="hidden" template-variable="category_slug" value="{slug}" />
<input type="hidden" template-variable="topic_count" value="{topic_count}" />
<input type="hidden" template-variable="currentPage" value="{currentPage}" />
<input type="hidden" template-variable="pageCount" value="{pageCount}" />

<div class="category row">
	<div class="col-md-9" no-widget-class="col-lg-12 col-sm-12" no-widget-target="sidebar">
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
		<div class="subcategories row">
			<!-- BEGIN children -->
			<div class="<!-- IF children.class -->{children.class}<!-- ELSE -->col-md-3 col-sm-6 col-xs-12<!-- ENDIF children.class --> category-item" data-cid="{children.cid}" data-numRecentReplies="{children.numRecentReplies}">
				<meta itemprop="name" content="{children.name}">

				<div class="category-icon">

					<!-- IF children.link -->
					<a style="color: {children.color};" href="{children.link}" itemprop="url" target="_blank">
					<!-- ELSE -->
					<a style="color: {children.color};" href="{config.relative_path}/category/{children.slug}" itemprop="url">
					<!-- ENDIF children.link -->
						<div
							id="category-{children.cid}" class="category-header category-header-image-{children.imageClass}"
							style="
								<!-- IF children.backgroundImage -->background-image: url({children.backgroundImage});<!-- ENDIF children.backgroundImage -->
								<!-- IF children.bgColor -->background-color: {children.bgColor};<!-- ENDIF children.bgColor -->
								color: {children.color};
							"
						>
							<!-- IF !children.link -->
							<span class="badge {children.unread-class}"><i class="fa fa-book" data-toggle="tooltip" title="[[global:topics]]"></i> <span class="human-readable-number" title="{children.totalTopicCount}">{children.totalTopicCount}</span>&nbsp; <i class="fa fa-pencil" data-toggle="tooltip" title="[[global:posts]]"></i> <span class="human-readable-number" title="{children.totalPostCount}">{children.totalPostCount}</span></span>
							<!-- ENDIF !children.link -->

							<!-- IF children.icon -->
							<div><i class="fa {children.icon} fa-4x"></i></div>
							<!-- ENDIF children.icon -->
						</div>
					</a>

					<div class="category-box">
						<div class="category-info">
							<!-- IF children.link -->
							<a href="{children.link}" itemprop="url" target="_blank">
							<!-- ELSE -->
							<a href="{config.relative_path}/category/{children.slug}" itemprop="url">
							<!-- ENDIF children.link-->
								<h4><!-- IF children.icon --><i class="fa {children.icon} visible-xs-inline"></i> <!-- ENDIF children.icon -->{children.name}</h4>
							</a>
							<div class="description" itemprop="description">{children.description}</div>
						</div>
						<!-- IF !children.link -->
						<!-- BEGIN posts -->
						<div class="post-preview clearfix">
							<div class="post-preview-content">
								<strong><a href="{config.relative_path}/topic/{children.posts.topic.slug}">{children.posts.topic.title}</a></strong>
								<hr/>
								<a style="color: {children.color};" href="<!-- IF children.posts.user.userslug -->{config.relative_path}/user/{children.posts.user.userslug}<!-- ELSE -->#<!-- ENDIF children.posts.user.userslug-->">
									<img src="{children.posts.user.picture}" title="{children.posts.user.username}" class="pull-left user-img" />
								</a>
								<div class="content">
								{children.posts.content}
								</div>
								<p class="fade-out"></p>
							</div>
							<span class="pull-right post-preview-footer">
								<span class="timeago" title="{children.posts.relativeTime}"></span> &bull;
								<a href="{config.relative_path}/topic/{children.posts.topic.slug}<!-- IF children.posts.index -->/{children.posts.index}<!-- ENDIF children.posts.index -->">[[global:read_more]]</a>
							</span>
						</div>
						<!-- END posts -->
						<!-- ENDIF !children.link -->
					</div>
				</div>
			</div>
			<!-- END children -->
		</div>

		<div class="header category-tools clearfix">
			<!-- IF privileges.topics:create -->
			<button id="new_topic" class="btn btn-primary">[[category:new_topic_button]]</button>
			<!-- ELSE -->
				<!-- IF !loggedIn -->
				<a href="{config.relative_path}/login" class="btn btn-primary">[[category:guest-login-post]]</a>
				<!-- ENDIF !loggedIn -->
			<!-- ENDIF privileges.topics:create -->

			<span class="pull-right">
				<!-- IF loggedIn -->
				<button type="button" class="btn btn-default btn-success watch <!-- IF !isIgnored -->hidden<!-- ENDIF !isIgnored -->">
					<i class="fa fa-eye"></i>
					<span class="visible-sm-inline visible-md-inline visible-lg-inline">[[category:watch]]</span>
				</button>
				<button type="button" class="btn btn-default btn-warning ignore <!-- IF isIgnored -->hidden<!-- ENDIF isIgnored -->">
					<i class="fa fa-eye-slash"></i>
					<span class="visible-sm-inline visible-md-inline visible-lg-inline">[[category:ignore]]</span>
				</button>
				<!-- ENDIF loggedIn -->

<!-- IF privileges.editable -->
<div class="btn-group thread-tools">
	<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">
		<span class="visible-sm-inline visible-md-inline visible-lg-inline">[[topic:thread_tools.title]]</span>
		<span class="visible-xs-inline"><i class="fa fa-fw fa-gear"></i></span>
		<span class="caret"></span>
	</button>
	<ul class="dropdown-menu pull-right">
		<li>
			<a component="topic/mark-unread-for-all" href="#">
				<i class="fa fa-fw fa-inbox"></i> [[topic:thread_tools.markAsUnreadForAll]]
			</a>
		</li>
		<li>
			<a component="topic/pin" href="#">
				<i class="fa fa-fw fa-thumb-tack"></i> [[topic:thread_tools.pin]]
			</a>
		</li>
		<li>
			<a component="topic/unpin" href="#" class="hidden">
				<i class="fa fa-fw fa-thumb-tack fa-rotate-90"></i> [[topic:thread_tools.unpin]]
			</a>
		</li>

		<li>
			<a component="topic/lock" href="#">
				<i class="fa fa-fw fa-lock"></i> [[topic:thread_tools.lock]]
			</a>
		</li>
		<li>
			<a component="topic/unlock" href="#" class="hidden">
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
			<a component="topic/move-all" href="#">
				<i class="fa fa-fw fa-arrows"></i> [[topic:thread_tools.move_all]]
			</a>
		</li>

		<li class="divider"></li>

		<li>
			<a component="topic/delete" href="#">
				<i class="fa fa-fw fa-trash-o"></i> [[topic:thread_tools.delete]]
			</a>
		</li>
		<li>
			<a component="topic/restore" href="#" class="hidden">
				<i class="fa fa-fw fa-history"></i> [[topic:thread_tools.restore]]
			</a>
		</li>
		<li>
			<a component="topic/purge" href="#" class="hidden">
				<i class="fa fa-fw fa-eraser"></i> [[topic:thread_tools.purge]]
			</a>
		</li>

		<!-- BEGIN thread_tools -->
		<li>
			<a href="#" class="{thread_tools.class}"><i class="fa fa-fw {thread_tools.icon}"></i> {thread_tools.title}</a>
		</li>
		<!-- END thread_tools -->
	</ul>
</div>
<!-- ENDIF privileges.editable -->

<!-- IF loggedIn -->
<div class="btn-group" component="thread/sort">
	<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">
		<span class="visible-sm-inline visible-md-inline visible-lg-inline">[[topic:sort_by]]</span>
		<span class="visible-xs-inline"><i class="fa fa-fw fa-sort"></i></span>
		<span class="caret"></span>
	</button>

	<ul class="dropdown-menu pull-right">
		<li><a href="#" class="newest_to_oldest" data-sort="newest_to_oldest"><i class="fa fa-fw"></i> [[topic:newest_to_oldest]]</a></li>
		<li><a href="#" class="oldest_to_newest" data-sort="oldest_to_newest"><i class="fa fa-fw"></i> [[topic:oldest_to_newest]]</a></li>
		<li><a href="#" class="most_posts" data-sort="most_posts"><i class="fa fa-fw"></i> [[topic:most_posts]]</a></li>
	</ul>
</div>
<!-- ENDIF loggedIn -->

				<div class="dropdown share-dropdown inline-block">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						<span class="visible-sm-inline visible-md-inline visible-lg-inline">[[topic:share]]</span>
						<span class="visible-xs-inline"><i class="fa fa-fw fa-share-alt"></i></span>
						<span class="caret"></span>
					</button>


<ul class="dropdown-menu pull-right" role="menu">

	<li role="presentation" class="dropdown-header">[[category:share_this_category]]</li>
	<!-- IF !config.disableSocialButtons -->
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
	<li class="text-center">
		<input id="category-link" readonly="true" type="text" value="" class="form-control post-link inline-block"></input>
	</li>
</ul>

				</div>
			</span>
		</div>
		<!-- IF !children.length -->
			<!-- IF !topics.length -->
			<div class="alert alert-warning" id="category-no-topics">
				[[category:no_topics]]
			</div>
			<!-- ENDIF !topics.length -->
		<!-- ENDIF !children.length -->


		<ul component="category" id="topics-container" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}">
			<meta itemprop="itemListOrder" content="descending">
			<!-- BEGIN topics -->
			<li component="category/topic" class="category-item {function.generateTopicClass}" data-tid="{topics.tid}" data-index="{topics.index}" data-cid="{topics.cid}" itemprop="itemListElement">

				<div class="category-body">
					<div class="row">
						<div class="col-md-8 col-sm-9">
							<!-- IF privileges.editable -->
								<i class="fa fa-fw fa-square-o pull-left select pointer"></i>
							<!-- ENDIF privileges.editable -->

							<div class="category-profile-pic">
								<a href="<!-- IF topics.user.userslug -->{config.relative_path}/user/{topics.user.userslug}<!-- ELSE -->#<!-- ENDIF topics.user.userslug -->">
									<!-- IF topics.thumb -->
									<img src="{topics.thumb}" alt="{topics.title}" class="profile-image user-img" title="{topics.title}">
									<!-- ELSE -->
									<img src="{topics.user.picture}" alt="{topics.user.username}" class="profile-image user-img" title="{topics.user.username}">
									<!-- ENDIF topics.thumb -->
								</a>
							</div>
							<div class="category-text">
								<p><strong><i component="topic/pinned" class="fa fa-thumb-tack<!-- IF !topics.pinned --> hide<!-- ENDIF !topics.pinned -->"></i> <i component="topic/locked" class="fa fa-lock<!-- IF !topics.locked --> hide<!-- ENDIF !topics.locked -->"></i></strong>
									<a component="topic/header" href="{config.relative_path}/topic/{topics.slug}" itemprop="url" class="topic-title">{topics.title}</a><br />
									<small>
									[[global:posted_ago, <span class="timeago" title="{topics.relativeTime}"></span>]]
									<!-- IF !topics.unreplied -->
									<span class="hidden-md hidden-lg">
									<br/>
									<a href="{config.relative_path}/topic/{topics.slug}/{topics.teaser.index}">[[global:replied_ago, <span class="timeago" title="{topics.teaser.timestamp}"></span>]]</a>
									</span>
									<!-- ENDIF !topics.unreplied -->
									<br/>
<!-- IF topics.tags.length -->
	<!-- BEGIN tags -->
		<a href="{config.relative_path}/tags/{topics.tags.value}"><span class="tag-item" data-tag="{topics.tags.value}" style="<!-- IF topics.tags.color -->color: {topics.tags.color};<!-- ENDIF topics.tags.color --><!-- IF topics.tags.bgColor -->background-color: {topics.tags.bgColor};<!-- ENDIF topics.tags.bgColor -->">{topics.tags.value}</span><span class="tag-topic-count">{topics.tags.score}</span></a>
	<!-- END tags -->
<!-- ENDIF topics.tags.length -->
									</small>
								</p>
							</div>
						</div>
						<div class="col-xs-1 category-stat hidden-xs">
							<strong class="human-readable-number" title="{topics.postcount}">{topics.postcount}</strong><br />
							<small>[[global:posts]]</small>
						</div>
						<div class="col-xs-1 category-stat hidden-xs">
							<strong class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</strong><br />
							<small>[[global:views]]</small>
						</div>
						<div class="col-xs-2 category-stat replies hidden-sm hidden-xs">
							<!-- IF topics.unreplied -->
							<p class="no-replies">[[category:no_replies]]</p>
							<!-- ELSE -->
							<a href="<!-- IF topics.teaser.user.userslug -->{config.relative_path}/user/{topics.teaser.user.userslug}<!-- ELSE -->#<!-- ENDIF topics.teaser.user.userslug -->"><img class="profile-image small user-img" src="{topics.teaser.user.picture}" title="{topics.teaser.user.username}" /></a>
							<a href="{config.relative_path}/topic/{topics.slug}/{topics.teaser.index}">
								[[global:replied_ago, <span class="timeago" title="{topics.teaser.timestamp}"></span>]]
							</a>
							<!-- ENDIF topics.unreplied -->
						</div>
					</div>
				</div>

			</li>
			<!-- END topics -->
		</ul>
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
	</div>

	<div widget-area="sidebar" class="col-md-3 col-xs-12 category-sidebar"></div>
</div>

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
