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

<div class="search">
	<div class="row">
		<div class="col-xs-12">
			<form id="advanced-search">
				<div class="form-group">
					<div class="row">
						<div class="col-md-5">
							<label>[[global:search]]</label>
							<input type="text" class="form-control" id="search-input" placeholder="[[global:search]]">
						</div>
						<div class="col-md-5">
							<label>[[search:in]]</label>
							<select id="search-in" class="form-control">
								<option value="titlesposts">[[search:titles-posts]]</option>
								<option value="titles">[[search:titles]]</option>
								<option value="posts">[[global:posts]]</option>
								<option value="users">[[global:users]]</option>
								<option value="tags">[[tags:tags]]</option>
							</select>
						</div>
						<div class="col-md-2">
							<label>&nbsp;</label>
							<button type="submit" class="btn btn-default form-control">[[global:search]]</button>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" data-target=".search-options">
						<h3 class="panel-title"><i class="fa fa-caret-down"></i> [[search:advanced-search]]</h3>
					</div>
					<div class="panel-body search-options collapse <!-- IF expandSearch -->in<!-- ENDIF expandSearch -->">

						<div class="form-group post-search-item">
							<label>[[search:posted-by]]</label>
							<input type="text" class="form-control" id="posted-by-user" placeholder="[[search:posted-by]]">
						</div>

						<div class="form-group post-search-item">
							<label>[[search:in-categories]]</label>
							<select multiple class="form-control" id="posted-in-categories">
								<option value="all">All Categories</option>
								<option value="watched">Watched Categories</option>
								<!-- BEGIN categories -->
								<option value="{categories.cid}">{categories.name}</option>
								<!-- END categories -->
							</select>
							<input type="checkbox" id="search-children"> [[search:search-child-categories]]
						</div>

						<div class="form-group post-search-item">
							<label>[[search:reply-count]]</label>
							<div class="row">
								<div class="col-md-6">
									<select id="reply-count-filter" class="form-control">
										<option value="atleast">[[search:at-least]]</option>
										<option value="atmost">[[search:at-most]]</option>
									</select>
								</div>
								<div class="col-md-6">
									<input type="text" class="form-control" id="reply-count">
								</div>
							</div>
						</div>

						<div class="form-group post-search-item">
							<label>[[search:post-time]]</label>
							<div class="row">
								<div class="col-md-6">
									<select id="post-time-filter" class="form-control">
										<option value="newer">[[search:newer-than]]</option>
										<option value="older">[[search:older-than]]</option>
									</select>
								</div>
								<div class="col-md-6">
									<select id="post-time-range" class="form-control">
										<option value="">[[search:any-date]]</option>
										<option value="86400">[[search:yesterday]]</option>
										<option value="604800">[[search:one-week]]</option>
										<option value="1209600">[[search:two-weeks]]</option>
										<option value="2592000">[[search:one-month]]</option>
										<option value="7776000">[[search:three-months]]</option>
										<option value="15552000">[[search:six-months]]</option>
										<option value="31104000">[[search:one-year]]</option>
									</select>
								</div>
							</div>
						</div>

						<div class="form-group post-search-item">
							<label>[[search:sort-by]]</label>
							<div class="row">
								<div class="col-md-6">
									<select id="post-sort-by" class="form-control">
										<option value="timestamp">[[search:post-time]]</option>
										<option value="teaser.timestamp">[[search:last-reply-time]]</option>
										<option value="topic.title">[[search:topic-title]]</option>
										<option value="topic.postcount">[[search:number-of-replies]]</option>
										<option value="topic.viewcount">[[search:number-of-views]]</option>
										<option value="topic.timestamp">[[search:topic-start-date]]</option>
										<option value="user.username">[[search:username]]</option>
										<option value="category.name">[[search:category]]</option>
									</select>
								</div>
								<div class="col-md-6">
									<select id="post-sort-direction" class="form-control">
										<option value="desc">[[search:descending]]</option>
										<option value="asc">[[search:ascending]]</option>
									</select>
								</div>
							</div>
						</div>

						<div class="form-group post-search-item">
							<label>[[search:show-results-as]]</label>
							<div class="btn-group" data-toggle="buttons" id="show-results-as">
								<label class="btn btn-primary active">
									<input type="radio" name="options" id="show-as-posts" autocomplete="off" checked> [[global:posts]]
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="options" id="show-as-topics" autocomplete="off"> [[global:topics]]
								</label>
							</div>
						</div>


						<a id="save-preferences" href="#">[[search:save-preferences]]</a>
						<a id="clear-preferences" href="#">[[search:clear-preferences]]</a>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div class="row">
		<div id="results" class="col-md-12" data-search-query="{search_query}">
			<!-- IF matchCount -->
			<div class="alert alert-info">[[search:results_matching, {matchCount}, {search_query}, {time}]] </div>
			<!-- ELSE -->
			<!-- IF search_query -->
			<div class="alert alert-warning">[[search:no-matches]]</div>
			<!-- ENDIF search_query -->
			<!-- ENDIF matchCount -->

			<!-- BEGIN posts -->
			<div class="topic-row panel panel-default clearfix">
				<div class="panel-body">

					<a href="{config.relative_path}/topic/{posts.topic.slug}/{posts.index}" class="search-result-text">
						<h4>{posts.topic.title}</h4>
					</a>
					<!-- IF showAsPosts -->
					<div class="search-result-text">
						{posts.content}
						<p class="fade-out"></p>
					</div>
					<!-- ENDIF showAsPosts -->

					<small>
						<span class="pull-right post-preview-footer">
							<a href="{config.relative_path}/user/{posts.user.userslug}"><img class="user-img" title="{posts.user.username}" src="{posts.user.picture}"/></a>
							[[global:posted_in_ago, <a href="{config.relative_path}/category/{posts.category.slug}"><i class="fa {posts.category.icon}"></i> {posts.category.name}</a>, <span class="timeago" title="{posts.relativeTime}"></span>]]
						</span>
					</small>
				</div>
			</div>
			<!-- END posts -->

			<!-- IF users.length -->
			<ul id="users-container" class="users-container">
<!-- BEGIN users -->
<li class="users-box registered-user" data-uid="{users.uid}">
	<a href="{config.relative_path}/user/{users.userslug}"><img src="{users.picture}" class="img-thumbnail"/></a>
	<br/>
	<div class="user-info">
		<span>
			<i component="user/status" class="fa fa-circle status {users.status}" title="[[global:{users.status}]]"></i>
			<a href="{config.relative_path}/user/{users.userslug}">{users.username}</a>
		</span>
		<br/>
		<div title="reputation" class="reputation">
			<i class='fa fa-star'></i>
			<span class='formatted-number'>{users.reputation}</span>
		</div>
		<div title="post count" class="post-count">
			<i class='fa fa-pencil'></i>
			<span class='formatted-number'>{users.postcount}</span>
		</div>
	</div>
</li>
<!-- END users -->
			</ul>
			<!-- ENDIF users.length -->

			<!-- IF tags.length -->
<!-- BEGIN tags -->
<h3 class="pull-left tag-container">
	<a href="{config.relative_path}/tags/{tags.value}" data-value="{tags.value}"><span class="tag-item" data-tag="{tags.value}" style="<!-- IF tags.color -->color: {tags.color};<!-- ENDIF tags.color --><!-- IF tags.bgColor -->background-color: {tags.bgColor};<!-- ENDIF tags.bgColor -->">{tags.value}</span><span class="tag-topic-count">{tags.score}</span></a>
</h3>
<!-- END tags -->
			<!-- ENDIF tags.length -->


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

		</div>
	</div>
</div>
