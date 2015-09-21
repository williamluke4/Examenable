<div class="unread">

	<div class="clearfix">
		<div class="pull-left">
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
		</div>

		<div class="markread btn-group pull-right<!-- IF !topics.length --> hidden<!-- ENDIF !topics.length -->">
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				[[unread:mark_as_read]] <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">

				<li role="presentation">
					<a id="markSelectedRead" role="menuitem" tabindex="-1" href="#">[[unread:selected]]</a>
				</li>

				<li role="presentation">
					<a id="markAllRead" role="menuitem" tabindex="-1" href="#">[[unread:all]]</a>
				</li>
				<li class="divider"></li>
				<!-- BEGIN categories -->
				<li role="presentation" class="category" data-cid="{categories.cid}">
					<a role="menu-item" href="#"><!-- IF categories.icon --><i class="fa fa-fw {categories.icon}"></i><!-- ENDIF icon --> {categories.name}</a>
				</li>
				<!-- END categories -->
			</ul>
		</div>

		<div class="btn-group pull-right">
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				<!-- IF selectedCategory --><!-- IF selectedCategory.icon --><i class="fa fa-fw {selectedCategory.icon}"></i><!-- ENDIF selectedCategory.icon --> {selectedCategory.name}<!-- ELSE -->
				[[unread:all_categories]]<!-- ENDIF selectedCategory --> <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li role="presentation" class="category">
					<a role="menu-item" href="{config.relative_path}/unread"><i class="fa fa-fw <!-- IF !selectedCategory -->fa-check<!-- ENDIF !selectedCategory -->"></i> [[unread:all_categories]]</a>
				</li>
				<!-- BEGIN categories -->
				<li role="presentation" class="category" data-cid="{categories.cid}">
					<a role="menu-item" href="{config.relative_path}/unread?cid={categories.cid}"><i class="fa fa-fw <!-- IF categories.selected -->fa-check<!-- ENDIF categories.selected -->"></i><!-- IF categories.icon --><i class="fa fa-fw {categories.icon}"></i><!-- ENDIF categories.icon --> {categories.name}</a>
				</li>
				<!-- END categories -->
			</ul>
		</div>
	</div>

	<hr />

	<div class="category">
		<div id="category-no-topics" class="alert alert-warning <!-- IF topics.length -->hidden<!-- ENDIF topics.length -->">
			<strong>[[unread:no_unread_topics]]</strong>
		</div>

		<a href="{config.relative_path}/unread">
			<div class="alert alert-warning hide" id="new-topics-alert"></div>
		</a>

<ul component="category" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}">
	<meta itemprop="itemListOrder" content="descending">
	<!-- BEGIN topics -->
	<li component="category/topic" class="row clearfix {function.generateTopicClass}"data-tid="{topics.tid}" data-index="{topics.index}" data-cid="{topics.cid}" itemprop="itemListElement">
		<meta itemprop="name" content="{function.stripTags, title}">

		<div class="col-md-7 col-sm-9 col-xs-11 content">
			<div class="avatar pull-left">
				<!-- IF showSelect -->
					<div class="select fa-square-o">
						<img src="<!-- IF topics.thumb -->{topics.thumb}<!-- ELSE -->{topics.user.picture}<!-- ENDIF topics.thumb -->" class="img-circle user-img" />
						<i class="fa fa-check"></i>
					</div>
				<!-- ELSE -->
					<a href="{config.relative_path}/user/{topics.user.userslug}" class="pull-left">
						<img src="<!-- IF topics.thumb -->{topics.thumb}<!-- ELSE -->{topics.user.picture}<!-- ENDIF topics.thumb -->" class="img-circle user-img" title="{topics.user.username}"/>
					</a>
				<!-- ENDIF showSelect -->
			</div>

			<h1 component="topic/header" class="title">
				<i component="topic/pinned" class="fa fa-thumb-tack <!-- IF !topics.pinned -->hide<!-- ENDIF !topics.pinned -->"></i>
				<i component="topic/locked" class="fa fa-lock <!-- IF !topics.locked -->hide<!-- ENDIF !topics.locked -->"></i>
				<a href="{config.relative_path}/topic/{topics.slug}" itemprop="url">{topics.title}</a><br />

				<!-- IF !template.category -->
				<small>
					<a href="{config.relative_path}/category/{topics.category.slug}"><i class="fa {topics.category.icon}"></i> {topics.category.name}</a> &bull;
				</small>
				<!-- ENDIF !template.category -->

				<span class="tag-list">
					<!-- BEGIN tags -->
					<a href="{config.relative_path}/tags/{topics.tags.value}"><span class="tag" style="<!-- IF topics.tags.color -->color: {topics.tags.color};<!-- ENDIF topics.tags.color --><!-- IF topics.tags.bgColor -->background-color: {topics.tags.bgColor};<!-- ENDIF topics.tags.bgColor -->">{topics.tags.value}</span></a>
					<!-- END tags -->
					<!-- IF topics.tags.length --><small>&bull;</small><!-- ENDIF topics.tags.length -->
				</span>

				<small>[[global:posted_ago, <span class="timeago" title="{topics.relativeTime}"></span>]]</small>
			</h1>
		</div>

		<div class="col-md-1 hidden-sm hidden-xs stats">
			<span class="human-readable-number" title="{topics.postcount}">{topics.postcount}</span><br />
			<small>[[global:posts]]</small>
		</div>
		<div class="col-md-1 hidden-sm hidden-xs stats">
			<span class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</span><br />
			<small>[[global:views]]</small>
		</div>
		<div class="col-md-3 col-sm-3 col-xs-1 teaser hidden-xs">
			<div class="card" style="border-color: {topics.category.bgColor}">
				<!-- IF topics.unreplied -->
				<p class="hidden-xs">
					[[category:no_replies]]
				</p>
				<!-- ELSE -->
				<p class="hidden-xs">
					<strong>{topics.teaser.user.username}</strong>
					<a class="permalink" href="{config.relative_path}/topic/{topics.slug}/{topics.teaser.index}">
						<small class="timeago" title="{topics.teaser.timestamp}"></small>
					</a>
				</p>
				<div class="post-content">
					{topics.teaser.content}
				</div>
				<!-- ENDIF topics.unreplied -->
			</div>
		</div>
	</li>
	<!-- END topics -->
</ul>
		<button id="load-more-btn" class="btn btn-primary hide">[[unread:load_more]]</button>
	</div>
</div>
