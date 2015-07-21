var http = require("http");
var initialRequestOptions = {
	host : 'olhovivo.sptrans.com.br',
	port : 80,
	path : '/'
};
var secondRequestOptions = {
	host : 'olhovivo.sptrans.com.br',
	port : 80,
	path : '/v0/Parada/Buscar?termosBusca=Morato',
	headers : {
		// This cookie will be replaced by the one received on the previous request
		'Cookie' : 'apiCredentials=39D1DE24EB4A....'
	}
};
var firstRequest = http.request(initialRequestOptions, function(response) {
	var cookie = response.headers['set-cookie'];
	if (cookie) {
		cookie = (cookie + '').split(";")[0];
		secondRequestOptions.headers['Cookie'] = cookie;
	}
	var body = '';
	response.on('data', function(chunk) {
		body += chunk;
	});
	response.on('end', function() {
		var secondRequest = http.request(secondRequestOptions, function(responseNew) {
			var dataBody = '';
			responseNew.on('data', function(chunk) {
				dataBody += chunk;
			});
			responseNew.on('end', function() {
				console.log(dataBody);
			});
		});
		secondRequest.on('error', function(e) {
			console.log('problem with request: ' + e.message);
		});
		secondRequest.end();

	});
});
firstRequest.on('error', function(e) {
	console.log('problem with request: ' + e.message);
});
firstRequest.end(); 