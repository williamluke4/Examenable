<div class="clearfix">
	<div class="icon pull-left">
		<a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
			<img src="{posts.user.picture}" align="left" itemprop="image" />
			<!-- IF posts.user.banned -->
			<span class="label label-danger">[[user:banned]]</span>
			<!-- ENDIF posts.user.banned -->
		</a>
	</div>

	<small class="pull-left">
		<i component="user/status" class="fa fa-circle status {posts.user.status}" title="[[global:{posts.user.status}]]"></i>
		<strong>
			<a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->" itemprop="author" data-username="{posts.user.username}" data-uid="{posts.user.uid}">{posts.user.username}</a>
		</strong>

<!-- IF posts.user.groups.length -->
<!-- BEGIN groups -->
<!-- IF ../selected -->
<!-- IF ../userTitleEnabled -->
<a href="{config.relative_path}/groups/{../slug}"><small class="label group-label inline-block" style="background-color: {../labelColor};"><!-- IF ../icon --><i class="fa {../icon}"></i> <!-- ENDIF ../icon -->{../userTitle}</small></a>
<!-- ENDIF ../userTitleEnabled -->
<!-- ENDIF ../selected -->
<!-- END groups -->
<!-- ENDIF posts.user.groups.length -->

		<div class="visible-xs-block visible-sm-inline-block visible-md-inline-block visible-lg-inline-block">
			[[global:posted_ago, <a class="permalink" href="{config.relative_path}/topic/{slug}/{function.getBookmarkFromIndex}"><span class="timeago" title="{posts.relativeTime}"></span></a>]]
			<i class="fa fa-pencil-square pointer edit-icon <!-- IF !posts.editor.username -->hidden<!-- ENDIF !posts.editor.username -->"></i>

			<span class="post-tools">
				<a component="post/reply" href="#" class="no-select <!-- IF !privileges.topics:reply -->hidden<!--ENDIF !privileges.topics:reply -->">[[topic:reply]]</a>
				<a component="post/quote" href="#" class="no-select <!-- IF !privileges.topics:reply -->hidden<!--ENDIF !privileges.topics:reply -->">[[topic:quote]]</a>
			</span>
			<span>
				<!-- IF posts.user.custom_profile_info.length -->
				&#124;
				<!-- BEGIN custom_profile_info -->
				{posts.user.custom_profile_info.content}
				<!-- END custom_profile_info -->
				<!-- ENDIF posts.user.custom_profile_info.length -->
			</span>
		</div>
		<div class="votes">
			<!-- IF !reputation:disabled -->
			<a component="post/upvote" href="#" class="<!-- IF posts.upvoted -->upvoted<!-- ENDIF posts.upvoted -->">
				<i class="fa fa-chevron-up"></i>
			</a>
			<span component="post/vote-count" data-votes="{posts.votes}">{posts.votes}</span>
			<!-- IF !downvote:disabled -->
			<a component="post/downvote" href="#" class="<!-- IF posts.downvoted -->downvoted<!-- ENDIF posts.downvoted -->">
				<i class="fa fa-chevron-down"></i>
			</a>
			<!-- ENDIF !downvote:disabled -->
			<!-- ENDIF !reputation:disabled -->
		</div>

<div class="dropdown moderator-tools">
	<a href="#" data-toggle="dropdown"><i class="fa fa-fw fa-ellipsis-v"></i></a>
	<ul class="dropdown-menu dropdown-menu-right" role="menu">

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
	</small>
</div>

<br />
<div class="content" component="post/content" itemprop="text">
	{posts.content}
</div>
<!-- IF posts.user.signature -->
<div component="post/signature" data-uid="{posts.user.uid}" class="post-signature">{posts.user.signature}</div>
<!-- ENDIF posts.user.signature -->


<small data-editor="{posts.editor.userslug}" component="post/editor" class="hidden">[[global:last_edited_by_ago, <strong>{posts.editor.username}</strong>, <span class="timeago" title="{posts.relativeEditTime}"></span>]]</small>


<hr />
