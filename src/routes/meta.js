"use strict";

var meta = require('../meta'),
	middleware = require('../middleware');


function sendMinifiedJS(req, res, next) {
	res.type('text/javascript').send(meta.js.cache);
}

// The portions of code involving the source map are commented out as they're broken in UglifyJS2
// Follow along here: https://github.com/mishoo/UglifyJS2/issues/700
// function sendJSSourceMap(req, res) {
// 	if (meta.js.hasOwnProperty('map')) {
// 		res.type('application/json').send(meta.js.map);
// 	} else {
// 		res.redirect(404);
// 	}
// };

function sendStylesheet(req, res, next) {
	res.type('text/css').status(200).send(meta.css.cache);
}

function sendACPStylesheet(req, res, next) {
	res.type('text/css').status(200).send(meta.css.acpCache);
}

module.exports = function(app, middleware, controllers) {
	app.get('/stylesheet.css', middleware.addExpiresHeaders, sendStylesheet);
	app.get('/admin.css', middleware.addExpiresHeaders, sendACPStylesheet);
	app.get('/nodebb.min.js', middleware.addExpiresHeaders, sendMinifiedJS);
	// app.get('/nodebb.min.js.map', middleware.addExpiresHeaders, sendJSSourceMap);
	app.get('/sitemap.xml', controllers.sitemap);
	app.get('/robots.txt', controllers.robots);
	app.get('/css/previews/:theme', controllers.admin.themes.get);
};
