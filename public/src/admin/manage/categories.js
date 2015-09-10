"use strict";
/*global define, socket, app, bootbox, templates, ajaxify, RELATIVE_PATH, Sortable */

define('admin/manage/categories', ['vendor/jquery/serializeObject/jquery.ba-serializeobject.min'], function() {
	var	Categories = {}, newCategoryId = -1, sortables;

	Categories.init = function() {
		socket.emit('admin.categories.getAll', function(error, payload){
			if(error){
				return app.alertError(error.message);
			}

			Categories.render(payload);
		});

		$('button[data-action="create"]').on('click', Categories.throwCreateModal);

		// Enable/Disable toggle events
		$('.categories').on('click', 'button[data-action="toggle"]', function() {
			var self = $(this),
				rowEl = self.parents('li'),
				cid = rowEl.attr('data-cid'),
				disabled = rowEl.hasClass('disabled');

			Categories.toggle(cid, disabled);
		});
	};

	Categories.throwCreateModal = function() {
		socket.emit('admin.categories.getNames', {}, function(err, categories) {
			templates.parse('admin/partials/categories/create', {
				categories: categories
			}, function(html) {
				var modal = bootbox.dialog({
					title: 'Create a Category',
					message: html,
					buttons: {
						save: {
							label: 'Save',
							className: 'btn-primary',
							callback: function() {
								var formData = modal.find('form').serializeObject();
								formData.description = '';
								formData.icon = 'fa-comments';

								Categories.create(formData);
							}
						}
					}
				});
			});
		});
	};

	Categories.create = function(payload) {
		socket.emit('admin.categories.create', payload, function(err, data) {
			if(err) {
				return app.alertError(err.message);
			}

			app.alert({
				alert_id: 'category_created',
				title: 'Created',
				message: 'Category successfully created!',
				type: 'success',
				timeout: 2000
			});

			ajaxify.go('admin/manage/categories/' + data.cid);
		});
	};

	Categories.render = function(categories){
		var container = $('.categories');

		if (!categories || categories.length == 0) {
			$('<div></div>')
				.addClass('alert alert-info text-center')
				.text('You have no active categories.')
				.appendTo(container);
		} else {
			sortables = {};
			renderList(categories, container, 0);
		}
	};

	Categories.toggle = function(cid, state) {
		var payload = {};

		payload[cid] = {
			disabled: !state | 0
		};

		socket.emit('admin.categories.update', payload, function(err, result) {
			if (err) {
				return app.alertError(err.message);
			} else {
				ajaxify.refresh();
			}
		});
	}

	function itemDidAdd(e){
		newCategoryId = e.to.dataset.cid;
	}

	function itemDragDidEnd(e){
		var isCategoryUpdate = (newCategoryId != -1);
		//Update needed?
		if((e.newIndex != undefined && e.oldIndex != e.newIndex) || isCategoryUpdate){
			var parentCategory = isCategoryUpdate ? sortables[newCategoryId] : sortables[e.from.dataset.cid],
				modified = {}, i = 0, list = parentCategory.toArray(), len = list.length;

			for(i; i < len; ++i) {
				modified[list[i]] = {
					order: (i + 1)
				}
			}

			if(isCategoryUpdate){
				modified[e.item.dataset.cid]['parentCid'] = newCategoryId;
			}

			newCategoryId = -1
			socket.emit('admin.categories.update', modified);
		}
	}

	/**
	 * Render categories - recursively
	 *
	 * @param categories {array} categories tree
	 * @param level {number} current sub-level of rendering
	 * @param container {object} parent jquery element for the list
	 * @param parentId {number} parent category identifier
	 */
	function renderList(categories, container, parentId){
		templates.parse('admin/partials/categories/category-rows', {
			cid: parentId,
			categories: categories
		}, function(html) {
			container.append(html);

			// Handle and children categories in this level have
			for(var x=0,numCategories=categories.length;x<numCategories;x++) {
				if (categories[x].hasOwnProperty('children') && categories[x].children.length > 0) {
					renderList(categories[x].children, $('li[data-cid="' + categories[x].cid + '"]'), categories[x].cid);
				}
			}

			// Make list sortable
			sortables[parentId] = Sortable.create($('ul[data-cid="' + parentId + '"]')[0], {
				group: 'cross-categories',
				animation: 150,
				handle: '.icon',
				dataIdAttr: 'data-cid',
				ghostClass: "placeholder",
				onAdd: itemDidAdd,
				onEnd: itemDragDidEnd
			});
		});
	}

	return Categories;
});