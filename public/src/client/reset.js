"use strict";
/*globals define, app, socket*/

define('forum/reset', function() {
	var	ResetPassword = {};

	ResetPassword.init = function() {
		var inputEl = $('#email'),
			errorEl = $('#error'),
			successEl = $('#success');

		$('#reset').on('click', function() {
			if (inputEl.val() && inputEl.val().indexOf('@') !== -1) {
				socket.emit('user.reset.send', inputEl.val(), function(err) {
					if(err) {
						return app.alertError(err.message);
					}

					errorEl.addClass('hide').hide();
					successEl.removeClass('hide').show();
					inputEl.val('');
				});
			} else {
				successEl.addClass('hide').hide();
				errorEl.removeClass('hide').show();
			}
			return false;
		});
	};

	return ResetPassword;
});
