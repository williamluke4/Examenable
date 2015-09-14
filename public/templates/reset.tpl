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


<div class="alert alert-info">
	[[reset_password:enter_email]]
</div>

<div class="well">
	<div class="alert alert-success" id="success" style="display:none">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<strong>[[reset_password:password_reset_sent]]</strong>
	</div>
	<div class="alert alert-danger" id="error" style="display:none">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<strong>[[reset_password:invalid_email]]</strong>
	</div>
	<form onsubmit="return false;">
		<input type="text" class="form-control input-block input-lg" placeholder="[[reset_password:enter_email_address]]" id="email" />

		<br />
		<button class="btn btn-primary btn-block btn-lg" id="reset" type="submit">[[reset_password:reset_password]]</button>
	</form>
</div>
