'use strict';

/* globals define, app, socket*/

define('forum/popular', function() {
	var Popular = {};

	Popular.init = function() {
		app.enterRoom('popular_topics');

		selectActivePill();
	};

	function selectActivePill() {
		var active = getActiveSection();

		$('.nav-pills li').removeClass('active');
		$('.nav-pills li a').each(function() {
			var $this = $(this);
			if ($this.attr('href').match(active)) {
				$this.parent().addClass('active');
				return false;
			}
		});
	}

	function getActiveSection() {
		var parts = window.location.href.split('/');
		return parts[parts.length - 1];
	}

	return Popular;
});
