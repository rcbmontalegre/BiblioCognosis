var http = require("http");
var querystring = require('querystring');
var cheerio = require("cheerio");

var secondRequestOptions = {
	host : 'www.isp.pt',
	port : 80,
	method: 'GET',
	path : '/NR/exeres/36FAA444-8049-428C-8E89-09909A9C1300.htm?matricula=22-18-PC&data=20140327',
	headers : {
		'Cookie' : 'ASP.NET_SessionId=m34rg3j3frv1ow55ky0qdk55;avr_3947210203_0_0_4294901760_157059521_0=1807626741_5085861'
	}
};
// http://www.isp.pt/NR/exeres/36FAA444-8049-428C-8E89-09909A9C1300.htm?matricula=22-LB-27&data=20140327
var callback = function(response) {
  var str = '';
  response.on('data', function (chunk) {
    str += chunk;
  });
  response.on('end', function () {
    console.log(str);
  });
};

var secondRequest = http.request(secondRequestOptions, callback);
secondRequest.on('error', function(e) {
	console.log('problem with request: ' + e.message);
});
secondRequest.end();
