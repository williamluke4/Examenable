'use strict';


// Temp solution until
//   https://github.com/NodeBB/NodeBB/issues/2486
// and
//   https://github.com/Automattic/socket.io/issues/1945
// are closed.
// Once they are closed switch to .clients() and async calls


var pubsub = require('../pubsub'),
	async = require('async');

var rooms = {};

var clientRooms = {};
var roomClients = {};

rooms.enter = function(socket, room) {
	socket.join(room);
	pubsub.publish('socket:join', {id: socket.id, room: room});
};

rooms.leave = function(socket, room) {
	socket.leave(room);
	pubsub.publish('socket:leave', {id: socket.id, room: room});
};

rooms.leaveAll = function(socket, roomsToLeave) {
	roomsToLeave.forEach(function(room) {
		rooms.leave(socket, room);
	});
};

rooms.broadcast = function(socket, room, msg, data, callback) {
	var io = require('./'),
		socketIds = rooms.clients(room);

	callback = callback || function() {};

	// Filter out socketIds that aren't actually connected
	socketIds = socketIds.filter(function(id) {
		return io.server.sockets.connected.hasOwnProperty(id);
	});

	async.map(socketIds, function(id, next) {
		var timeout,
			timeoutPassed = false;

		if (socket.id === id) {
			return setImmediate(next, null, []);
		}

		timeout = setTimeout(function() {
			timeoutPassed = true;
			next(null, []);
		}, 500);

		io.server.sockets.connected[id].emit(msg, data || {}, function(err, returnData) {
			clearTimeout(timeout);
			if (!timeoutPassed) {
				next(null, returnData);
			}
		});
	}, callback);
};

pubsub.on('socket:join', onSocketJoin);
pubsub.on('socket:leave', onSocketLeave);

function onSocketJoin(data) {
	clientRooms[data.id] = clientRooms[data.id] || [];
	if (clientRooms[data.id].indexOf(data.room) === -1) {
		clientRooms[data.id].push(data.room);
	}

	roomClients[data.room] = roomClients[data.room] || [];
	if (roomClients[data.room].indexOf(data.id) === -1) {
		roomClients[data.room].push(data.id);
	}
}


function onSocketLeave(data) {
	var index;
	if (Array.isArray(clientRooms[data.id])) {
		index = clientRooms[data.id].indexOf(data.room);
		if (index !== -1) {
			clientRooms[data.id].splice(index, 1);
			if (!clientRooms[data.id].length) {
				delete clientRooms[data.id];
			}
		}
	}

	if (Array.isArray(roomClients[data.room])) {
		index = roomClients[data.room].indexOf(data.id);
		if (index !== -1) {
			roomClients[data.room].splice(index, 1);
			if (!roomClients[data.room].length) {
				delete roomClients[data.room];
			}
		}
	}
}


rooms.clients = function(room) {
	return Array.isArray(roomClients[room]) ? roomClients[room] : [];
};

rooms.clientRooms = function(id) {
	return Array.isArray(clientRooms[id]) ? clientRooms[id] : [];
};

rooms.socketCount = function() {
	return Object.keys(clientRooms || {}).length;
};

rooms.roomClients = function() {
	return roomClients;
};




module.exports = rooms;

