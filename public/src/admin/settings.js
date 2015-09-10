"use strict";
/*global define, app, socket, ajaxify, RELATIVE_PATH */

define('admin/settings', ['uploader', 'sounds'], function(uploader, sounds) {
	var Settings = {};

	Settings.init = function() {
		if (!app.config) {
			$(window).on('action:config.loaded', Settings.prepare);
		} else {
			Settings.prepare();
		}
	};

	Settings.populateTOC = function() {
		$('.settings-header').each(function() {
			var header = $(this).text(),
				anchor = header.toLowerCase().replace(/ /g, '-').trim();

			$(this).prepend('<a name="' + anchor + '"></a>');
			$('.section-content ul').append('<li><a href="#' + anchor + '">' + header + '</a></li>');
		});
	};

	Settings.prepare = function(callback) {
		// Populate the fields on the page from the config
		var fields = $('#content [data-field]'),
			numFields = fields.length,
			saveBtn = $('#save'),
			revertBtn = $('#revert'),
			x, key, inputType, field;

		for (x = 0; x < numFields; x++) {
			field = fields.eq(x);
			key = field.attr('data-field');
			inputType = field.attr('type');
			if (field.is('input')) {
				if (app.config[key]) {
					switch (inputType) {
					case 'text':
					case 'hidden':
					case 'password':
					case 'textarea':
					case 'number':
						field.val(app.config[key]);
						break;

					case 'checkbox':
						field.prop('checked', parseInt(app.config[key], 10) === 1);
						break;
					}
				}
			} else if (field.is('textarea')) {
				if (app.config[key]) {
					field.val(app.config[key]);
				}
			} else if (field.is('select')) {
				if (app.config[key]) {
					field.val(app.config[key]);
				}
			}
		}

		revertBtn.off('click').on('click', function(e) {
			ajaxify.refresh();
		});

		saveBtn.off('click').on('click', function(e) {
			e.preventDefault();

			saveFields(fields, function onFieldsSaved(err) {
				if (err) {
					return app.alert({
						alert_id: 'config_status',
						timeout: 2500,
						title: 'Changes Not Saved',
						message: 'NodeBB encountered a problem saving your changes',
						type: 'danger'
					});
				}
				app.alert({
					alert_id: 'config_status',
					timeout: 2500,
					title: 'Changes Saved',
					message: 'Your changes to the NodeBB configuration have been saved.',
					type: 'success'
				});
			});
		});

		handleUploads();

		$('button[data-action="email.test"]').off('click').on('click', function() {
			socket.emit('admin.email.test', function(err) {
				if (err) {
					return app.alertError(err.message);
				}
				app.alertSuccess('Test Email Sent');
			});
			return false;
		});

		$('#clear-sitemap-cache').off('click').on('click', function() {
			socket.emit('admin.settings.clearSitemapCache', function() {
				app.alertSuccess('Sitemap Cache Cleared!');
			});
			return false;
		});

		if (typeof callback === 'function') {
			callback();
		}

		$(window).trigger('action:admin.settingsLoaded');
	};

	function handleUploads() {
		$('#content input[data-action="upload"]').each(function() {
			var uploadBtn = $(this);
			uploadBtn.on('click', function() {
				uploader.open(uploadBtn.attr('data-route'), {}, 0, function(image) {
					$('#' + uploadBtn.attr('data-target')).val(image);
				});

				uploader.hideAlerts();
			});
		});
	}

	Settings.remove = function(key) {
		socket.emit('admin.config.remove', key);
	};

	function saveFields(fields, callback) {
		var data = {};

		fields.each(function() {
			var field = $(this);
			var key = field.attr('data-field'),
				value, inputType;

			if (field.is('input')) {
				inputType = field.attr('type');
				switch (inputType) {
				case 'text':
				case 'password':
				case 'hidden':
				case 'textarea':
				case 'number':
					value = field.val();
					break;

				case 'checkbox':
					value = field.prop('checked') ? '1' : '0';
					break;
				}
			} else if (field.is('textarea') || field.is('select')) {
				value = field.val();
			}

			data[key] = value;
		});

		socket.emit('admin.config.setMultiple', data, function(err) {
			if (err) {
				return callback(err);
			}

			if (app.config) {
				for(var field in data) {
					if (data.hasOwnProperty(field)) {
						app.config[field] = data[field];
					}
				}
			}

			callback();
		});
	}

	return Settings;
});
