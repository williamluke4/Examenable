<div class="settings">
	<div class="row">
		<div class="col-sm-2 col-xs-12 content-header">
			Contents
		</div>
		<div class="col-sm-10 col-xs-12">
			<nav class="section-content">
				<ul></ul>
			</nav>
		</div>
	</div>

<div class="row">
	<div class="col-sm-2 col-xs-12 settings-header">General</div>
	<div class="col-sm-10 col-xs-12">
		<form role="form">
			<div class="checkbox">
				<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input class="mdl-switch__input" type="checkbox" data-field="allowPrivateGroups" checked>
					<span class="mdl-switch__label"><strong>Private Groups</strong></span>
				</label>
			</div>

			<p class="help-block">
				If enabled, joining of groups requires the approval of the group owner <em>(Default: enabled)</em>
			</p>
			<p class="help-block">
				<strong>Beware!</strong> If this option is disabled and you have private groups, they automatically become public.
			</p>

			<div class="checkbox">
				<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect">
					<input class="mdl-switch__input" type="checkbox" data-field="allowGroupCreation">
					<span class="mdl-switch__label"><strong>Allow Group Creation</strong></span>
				</label>
			</div>

			<p class="help-block">
				If enabled, users can create groups <em>(Default: disabled)</em>
			</p>
		</form>
	</div>
</div>

</div>

<button id="save" class="floating-button mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
	<i class="material-icons">save</i>
</button>

<script>
	require(['admin/settings'], function(Settings) {
		Settings.init();
		Settings.populateTOC();
	});
</script>
