<div class="row">
	<div class="col-lg-4">
		<!-- IF allowGroupCreation -->
		<button class="btn btn-primary" data-action="new"><i class="fa fa-plus"></i> [[groups:new_group]]</button>
		<!-- ENDIF allowGroupCreation -->
	</div>
	<div class="col-lg-8">
		<div class="row">
			<div class="col-xs-3 text-left pull-right">
				<select class="form-control" id="search-sort">
					<option value="alpha">[[groups:details.group_name]]</option>
					<option value="count">[[groups:details.member_count]]</option>
					<option value="date">[[groups:details.creation_date]]</option>
				</select>
			</div>
			<div class="col-xs-5 text-left pull-right">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="[[global:search]]" name="query" value="" id="search-text">
					<span id="search-button" class="input-group-addon search-button"><i class="fa fa-search"></i></span>
				</div>
			</div>
		</div>
	</div>
</div>

<hr />

<div component="groups/container" class="row" id="groups-list" data-nextstart={nextStart}>
	<!-- IF groups.length -->
	<!-- BEGIN groups -->
	<div class="col-lg-4 col-md-6 col-sm-12" component="groups/summary" data-slug="{groups.slug}">
		<div class="panel panel-default">
			<div class="panel-heading list-cover" style="<!-- IF groups.cover:url -->background-image: url({groups.cover:url});<!-- ENDIF groups.cover:url -->">
				<h3 class="panel-title">{groups.displayName} <small>{groups.memberCount}</small></h3>
			</div>
			<div class="panel-body">
				<ul class="members">
					<!-- BEGIN members -->
					<li>
						<a href="{config.relative_path}/user/{groups.members.userslug}">
							<img src="{groups.members.picture}" title="{groups.members.userslug}" />
						</a>
					</li>
					<!-- END members -->
					<!-- IF groups.truncated -->
					<li class="truncated"><i class="fa fa-ellipsis-h"></i></li>
					<!-- ENDIF groups.truncated -->
				</ul>
			</div>
		</div>
	</div>
	<!-- END groups -->
	<!-- ELSE -->
	<div class="col-xs-12">
		<div class="alert alert-warning">
		[[groups:no_groups_found]]
		</div>
	</div>
	<!-- ENDIF groups.length -->
</div>
