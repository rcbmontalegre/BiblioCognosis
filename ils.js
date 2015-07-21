var http = require("http");

// http://montalegre.opacnet.com/OPAC/default.aspx?ContentAreaControl=NewSession.ascx
// http://biblioteca.cm-penafiel.pt/OPAC/default.aspx?ContentAreaControl=palavra.ascx

var initialRequestOptions = {
  host: 'montalegre.opacnet.com',
  port: 80,
  path: '/OPAC/default.aspx?ContentAreaControl=ChooseDatabase.ascx',
  method: 'GET'
};

var dataRequestOptions = {
  host: 'montalegre.opacnet.com',
  port: 80,
  path: '/OPAC/default.aspx?ContentAreaControl=ShowRegHoldings.ascx&RegNo=5955',
  method: 'GET',
  headers: {
      'Cookie': 'ASP.NET_SessionId=xbx1vo550lzesiiqpwvvtp45'
	}
};

var req = http.request(initialRequestOptions, function(response) {
	console.log('STATUS: ' + response.statusCode);
	if (response.statusCode == 200) {
		console.log('Ok!');
	}
  console.log('HEADERS: ' + JSON.stringify(response.headers));
  var cookie = response.headers['set-cookie'];
  console.log('Cookie: ' + cookie);
	if (cookie) {
		// ASP.NET_SessionId=gdnbbk45v0oh1jnotsdaim45; path=/; HttpOnly
		cookie = (cookie + '').split(";")[0];
		console.log('New cookie: ' + cookie);
		dataRequestOptions.headers['Cookie'] = cookie;
		console.log('New options: ' + JSON.stringify(dataRequestOptions));
	}
	var body='';
	response.on('data', function (chunk) {
		body += chunk;
		// console.log('.'); // chunk.toString());
	});
	response.on('end', function () {
		console.log(body.substring(0,100));
		// get other pages...
		
		var reqData = http.request(dataRequestOptions, function(response) {
			console.log('STATUS: ' + response.statusCode);
			if (response.statusCode == 200) {
				console.log('Ok! Segunda página!');
			}
			var dataBody='';
			response.on('data', function (chunk) {
				dataBody += chunk;
				// console.log('.'); // chunk.toString());
			});
			response.on('end', function () {
				console.log(dataBody.substring(0,400));
			});
		});
		reqData.end();
		
	});
});

req.on('error', function(e) {
  console.log('problem with request: ' + e.message);
});

req.end();
