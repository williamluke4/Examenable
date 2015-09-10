<div id="navigation">
	<div class="col-lg-9">
		<div class="panel panel-default">
			<div class="panel-heading">Active Navigation</div>
			<div class="panel-body">
				<ul id="enabled">
					<!-- BEGIN enabled -->
					<li class="well">
						<form>
							<div class="row">
								<div class="col-sm-6">
									<label>ID: <small>optional</small>
										<input class="form-control" type="text" name="id" value="{enabled.id}" />
									</label>
									<label>Title: <small>shown upon mouseover</small>
										<input class="form-control" type="text" name="title" value="{enabled.title}" />
									</label>
									<label>Icon Class: <small><a href="http://fortawesome.github.io/Font-Awesome/cheatsheet/" target="_blank">pick one</a></small>
										<input class="form-control" type="text" name="iconClass" value="{enabled.iconClass}" />
									</label>
								</div>
								<div class="col-sm-6">
									<label>Route: <small>ex. /unread</small>
										<input class="form-control" type="text" name="route" value="{enabled.route}" />
									</label>
									<label>Text:
										<input class="form-control" type="text" name="text" value="{enabled.text}" />
									</label>
									<label>Text Class: <small>optional</small>
										<input class="form-control" type="text" name="textClass" value="{enabled.textClass}" />
									</label>
								</div>
							</div>

							<hr />

							<strong>Properties:</strong>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="property:adminOnly" <!-- IF enabled.properties.adminOnly -->checked<!-- ENDIF enabled.properties.adminOnly -->/> <strong>Only display to Admins</strong>
								</label>
							</div>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="property:loggedIn" <!-- IF enabled.properties.loggedIn -->checked<!-- ENDIF enabled.properties.loggedIn -->/> <strong>Only display to logged in users</strong>
								</label>
							</div>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="property:targetBlank" <!-- IF enabled.properties.targetBlank -->checked<!-- ENDIF enabled.properties.targetBlank -->/> <strong>Open in a new window</strong>
								</label>
							</div>


							<hr />
							<button class="btn btn-danger delete">Delete</button>
							<!-- IF enabled.enabled -->
							<button class="btn btn-warning toggle">Disable</button>
							<!-- ELSE -->
							<button class="btn btn-success toggle">Enable</button>
							<!-- ENDIF enabled.enabled -->
							<input type="hidden" name="enabled" value="{enabled.enabled}" />
						</form>
					</li>
					<!-- END enabled -->
				</ul>
			</div>
		</div>
	</div>

	<div class="col-lg-3">
		<div class="panel panel-default">
			<div class="panel-heading">Available Menu Items</div>
			<div class="panel-body">
				<ul id="available">
					<li data-id="custom" class="alert alert-warning">
						<strong>Custom Route</strong>
					</li>
					<!-- BEGIN available -->
					<li data-id="@index" class="alert <!-- IF available.core -->alert-info<!-- ELSE -->alert-success<!-- ENDIF available.core -->">
						<strong>{available.text}</strong> {available.route}
						<span class="pull-right badge"><!-- IF available.core -->core<!-- ELSE -->plugin<!-- ENDIF available.core --></span>
					</li>
					<!-- END available -->
					<input type="hidden" template-variable="available" value="{function.stringify, available}" />
				</ul>
			</div>
		</div>
	</div>
</div>

<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
	<i class="material-icons">save</i>
</button>