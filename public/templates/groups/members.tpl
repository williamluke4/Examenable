<div class="users">

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

	<div class="text-center {loadmore_display}">
		<button id="load-more-users-btn" class="btn btn-primary">[[users:load_more]]</button>
	</div>
</div>