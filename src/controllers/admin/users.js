"use strict";

var user = require('../../user'),
	meta = require('../../meta');


var usersController = {};

usersController.search = function(req, res, next) {
	res.render('admin/manage/users', {
		search_display: '',
		loadmore_display: 'hide',
		users: []
	});
};

usersController.sortByPosts = function(req, res, next) {
	getUsers('users:postcount', req, res, next);
};

usersController.sortByReputation = function(req, res, next) {
	getUsers('users:reputation', req, res, next);
};

usersController.sortByJoinDate = function(req, res, next) {
	getUsers('users:joindate', req, res, next);
};

usersController.banned = function(req, res, next) {
	getUsers('users:banned', req, res, next);
};

usersController.registrationQueue = function(req, res, next) {
	user.getRegistrationQueue(0, -1, function(err, data) {
		if (err) {
			return next(err);
		}
		res.render('admin/manage/registration', {users: data});
	})
};

function getUsers(set, req, res, next) {
	user.getUsersFromSet(set, req.uid, 0, 49, function(err, users) {
		if (err) {
			return next(err);
		}

		users = users.filter(function(user) {
			return user && parseInt(user.uid, 10);
		});

		res.render('admin/manage/users', {
			search_display: 'hidden',
			loadmore_display: 'block',
			users: users,
			yourid: req.uid,
			requireEmailConfirmation: parseInt(meta.config.requireEmailConfirmation, 10) === 1
		});
	});
}

usersController.getCSV = function(req, res, next) {
	user.getUsersCSV(function(err, data) {
		if (err) {
			return next(err);
		}
		res.attachment('users.csv');
		res.setHeader('Content-Type', 'text/csv');
		res.end(data);
	});
};

module.exports = usersController;
