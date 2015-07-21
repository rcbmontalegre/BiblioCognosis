var http = require("http");

// http://montalegre.opacnet.com/OPAC/default.aspx?ContentAreaControl=NewSession.ascx

var dataRequestOptions = {
	host : 'biblioteca.cm-penafiel.pt',
	port : 80,
	path : '/OPAC/default.aspx?ContentAreaControl=ShowRegHoldings.ascx&RegNo=2673',
	method : 'GET',
	headers : {
		'Cookie' : 'ASP.NET_SessionId=tr41lmgib5wh542rs3iqqp0d'
	}
};

var req = http.request(dataRequestOptions, function(response) {
	console.log('STATUS: ' + response.statusCode);
	if (response.statusCode == 200) {
		console.log('Ok!');
	}
	console.log('HEADERS: ' + JSON.stringify(response.headers));

	var body = '';
	response.on('data', function(chunk) {
		body += chunk;
		// console.log('.'); // chunk.toString());
	});
	response.on('end', function() {
		console.log(body); // .substring(0, 100));
	});
});

req.on('error', function(e) {
	console.log('problem with request: ' + e.message);
});

req.end();
