<span class="tags">
	<!-- BEGIN tags -->
	<a href="{config.relative_path}/tags/{tags.value}">
	<span class="tag-item" data-tag="{tags.value}" style="<!-- IF tags.color -->color: {tags.color};<!-- ENDIF tags.color --><!-- IF tags.bgColor -->background-color: {tags.bgColor};<!-- ENDIF tags.bgColor -->">{tags.value}</span>
	<span class="tag-topic-count human-readable-number" title="{tags.score}">{tags.score}</span></a>
	<!-- END tags -->
</span>

<div class="topic-main-buttons pull-right">
	<span class="loading-indicator btn pull-left hidden" done="0">
		<span class="hidden-xs">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
	</span>

	<div class="stats">
		<span component="topic/post-count" class="human-readable-number" title="{postcount}">{postcount}</span><br />
		<small>[[global:posts]]</small>
	</div>
	<div class="stats">
		<span class="human-readable-number" title="{viewcount}">{viewcount}</span><br />
		<small>[[global:views]]</small>
	</div>




<a component="topic/reply" href="#" class="btn btn-primary <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->">[[topic:reply]]</a>

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




<!-- IF privileges.view_thread_tools -->
<div class="btn-group thread-tools">
	<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">
		<span class="visible-sm-inline visible-md-inline visible-lg-inline">[[topic:thread_tools.title]]</span>
		<span class="visible-xs-inline"><i class="fa fa-fw fa-gear"></i></span>
		<span class="caret"></span>
	</button>
	<ul class="dropdown-menu dropdown-menu-right">
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
<div class="clearfix"></div>

<hr />