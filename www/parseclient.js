var NOOP = function(){};
var checkParams = function(name, success, error){
	var result = true;
	if(typeof error != 'function'){
		console.log("ParseClient." + name + " failure: failure parameter not a function");
		result = false;
	}

	if(typeof success != 'function'){
		console.log("ParseClient." + name + " failure: success parameter not a function");
		result = false;
	}
	return result;
};

var ParseClient = {
	connect: function(appId, key, success, error){
		success = success || NOOP;
		error = error || NOOP;
		if(checkParams('connect', success, error)){
			cordova.exec(success, error, 'ParsePhonegap', 'connect', [appId, key]);
		}
	},
	subscribe: function(channel, success, error){
		success = success || NOOP;
		error = error || NOOP;
		if(checkParams('subscribe', success, error)){
			cordova.exec(success, error, 'ParsePhonegap', 'subscribe', [channel]);
		}
	},
	unsubscribe: function(channel, success, error){
		success = success || NOOP;
		error = error || NOOP;
		if(checkParams('unsubscribe', success, error)){
			cordova.exec(success, error, 'ParsePhonegap', 'unsubscribe', [channel]);
		}
	},
	subscribedChannels: function(success, error){
		error = error || NOOP;
		if(checkParams('subscribedChannels', success, error)){
			cordova.exec(success, error, 'ParsePhonegap', 'subscribedChannels', []);
		}
	},
	instanceInfo: function(success, error){
		error = error || NOOP;
		if(checkParams('instanceInfo', success, error)){
			cordova.exec(success, error, 'ParsePhonegap', 'instanceInfo', []);
		}
	}
};

module.exports = ParseClient;