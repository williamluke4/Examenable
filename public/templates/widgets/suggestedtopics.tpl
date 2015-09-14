<div class="recent-replies">
	<ul class="suggested-topics">
<!-- BEGIN topics -->
<li class="clearfix">
	<a href="<!-- IF topics.user.userslug -->{relative_path}/user/{topics.user.userslug}<!-- ELSE -->#<!-- ENDIF topics.user.userslug -->"><img title="{topics.user.username}" class="profile-image user-img" src="{topics.user.picture}"/></a>
	<p>
		<a href="{config.relative_path}/topic/{topics.slug}">{topics.title}</a>
	</p>
	<span class="pull-right post-preview-footer">
		<span class="timeago" title="{topics.lastposttimeISO}"></span>
	</span>
</li>
<!-- END topics -->
	</ul>
</div>

<script>
'use strict';
/* globals app*/

$(document).ready(function() {
	app.createUserTooltips();
});
</script>
