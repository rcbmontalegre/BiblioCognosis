var http = require("http");
var querystring = require('querystring');
var cheerio = require("cheerio");
// http://www.isp.pt/NR/exeres/019EEB91-E357-4A7C-8BD2-B62293701692.htm
var firstRequestOptions = {
	host : 'www.isp.pt',
	port : 80,
	path : '/NR/exeres/019EEB91-E357-4A7C-8BD2-B62293701692.htm'
};
var post_data = querystring.stringify({
	'__EVENTTARGET' : 'btnPsqMatricula',
	'__EVENTARGUMENT' : '',
	'__VIEWSTATE' : 'dDwtMTEyMjI1Nzk2OTt0PDtsPGk8MT47PjtsPHQ8O2w8aTw0PjtpPDk+O2k8MTA+O2k8MTQ+O2k8MTU+Oz47bDx0PHA8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Pjs7Pjt0PHA8cDxsPFRleHQ7PjtsPE1hdHLDrWN1bGEgw6kgb2JyaWdhdMOzcmlhOz4+Oz47Oz47dDxwPHA8bDxGb3JlQ29sb3I7VmFsaWRhdGlvbkV4cHJlc3Npb247RXJyb3JNZXNzYWdlO0VuYWJsZUNsaWVudFNjcmlwdDtfIVNCOz47bDwyPFJlZD47XlthLXpBLVpcXGRcXHNcXC1dezAsMTV9JDtBcGVuYXMgY2FyYWN0ZXJlcyBhbGZhYsOpdGljb3MsIG51bcOpcmljb3MgZSAtLCBwb3IgZmF2b3IuLi47bzxmPjtpPDQ+Oz4+Oz47Oz47dDw7bDxpPDI+Oz47bDx0PHA8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Pjs7Pjs+Pjt0PDtsPGk8MD47PjtsPHQ8O2w8aTwwPjtpPDE+O2k8Mj47PjtsPHQ8cDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDE+O2k8Mz47aTw1PjtpPDc+O2k8OT47aTwxMT47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDE+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDE+O2k8Mz47aTw1PjtpPDc+O2k8OT47aTwxMT47aTwxMz47aTwxNT47aTwxOT47aTwyMT47aTwyMz47aTwyNT47aTwyNz47aTwyOT47aTwzMT47aTwzMz47aTwzNT47aTwzNz47aTwzOT47aTw0MT47aTw0Mz47aTw0NT47aTw0Nz47PjtsPHQ8O2w8aTwxPjs+O2w8dDxwPGw8VGV4dDs+O2w8XDx0ZCB1bnNlbGVjdGFibGU9Im9uIiBjbGFzcz0iY3N3bUJ1dHRvbiIgaWQ9ImNzd21NZW51QnV0dG9uRmlsZSIgb25tb3VzZW92ZXI9ImNzd21CdXR0b25TZWxlY3QodGhpcy5pZCwgJ0ZpbGUnKVw7IiBvbm1vdXNlb3V0PSJjc3dtQnV0dG9uVW5TZWxlY3QodGhpcy5pZClcOyIgb25tb3VzZWRvd249ImNzd21CdXR0b25Eb3duKHRoaXMuaWQsICdGaWxlJylcOyIgbm93cmFwIHN0eWxlPSJCT1JERVItVE9QLVdJRFRIOjBweFw7IFBBRERJTkctUklHSFQ6N3B4XDsgUEFERElORy1MRUZUOjdweFw7IEJPUkRFUi1MRUZULVdJRFRIOjBweFw7IEJPUkRFUi1CT1RUT00tV0lEVEg6MHB4XDsgUEFERElORy1CT1RUT006NXB4XDsgUEFERElORy1UT1A6NXB4XDsgQk9SREVSLVJJR0hULVdJRFRIOjBweCJcPk1hbmFnZXJcPC90ZFw+XDx0ZCB1bnNlbGVjdGFibGU9Im9uIiBjbGFzcz0iY3N3bUJ1dHRvbiIgaWQ9ImNzd21NZW51QnV0dG9uRWRpdCIgb25tb3VzZW92ZXI9ImNzd21CdXR0b25TZWxlY3QodGhpcy5pZCwgJ0VkaXQnKVw7IiBvbm1vdXNlb3V0PSJjc3dtQnV0dG9uVW5TZWxlY3QodGhpcy5pZClcOyIgb25tb3VzZWRvd249ImNzd21CdXR0b25Eb3duKHRoaXMuaWQsICdFZGl0JylcOyIgbm93cmFwIHN0eWxlPSJCT1JERVItVE9QLVdJRFRIOjBweFw7IFBBRERJTkctUklHSFQ6N3B4XDsgUEFERElORy1MRUZUOjdweFw7IEJPUkRFUi1MRUZULVdJRFRIOjBweFw7IEJPUkRFUi1CT1RUT00tV0lEVEg6MHB4XDsgUEFERElORy1CT1RUT006NXB4XDsgUEFERElORy1UT1A6NXB4XDsgQk9SREVSLVJJR0hULVdJRFRIOjBweCJcPlBhZ2VcPC90ZFw+XDx0ZCB1bnNlbGVjdGFibGU9Im9uIiBjbGFzcz0iY3N3bUJ1dHRvbiIgaWQ9ImNzd21NZW51QnV0dG9uSGVscCIgb25tb3VzZW92ZXI9ImNzd21CdXR0b25TZWxlY3QodGhpcy5pZCwgJ0hlbHAnKVw7IiBvbm1vdXNlb3V0PSJjc3dtQnV0dG9uVW5TZWxlY3QodGhpcy5pZClcOyIgb25tb3VzZWRvd249ImNzd21CdXR0b25Eb3duKHRoaXMuaWQsICdIZWxwJylcOyIgbm93cmFwIHN0eWxlPSJCT1JERVItVE9QLVdJRFRIOjBweFw7IFBBRERJTkctUklHSFQ6N3B4XDsgUEFERElORy1MRUZUOjdweFw7IEJPUkRFUi1MRUZULVdJRFRIOjBweFw7IEJPUkRFUi1CT1RUT00tV0lEVEg6MHB4XDsgUEFERElORy1CT1RUT006NXB4XDsgUEFERElORy1UT1A6NXB4XDsgQk9SREVSLVJJR0hULVdJRFRIOjBweCJcPkNoYW5uZWxcPC90ZFw+Oz4+Ozs+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+PjtsPGk8Mz47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+PjtsPGk8MT47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+PjtsPGk8MT47aTwzPjs+O2w8dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDE+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47Pj47Pj47Pj47PvCopEkw0q1Eqw6EbCeXNQTkP+RZ',
	'txtMatricula' : '22-LB-27',
	'DataMatricula' : 'txtDataMatricula_Ano:2014',
	'DataMatricula' : 'txtDataMatricula_Mes:3',
	'DataMatricula' : 'txtDataMatricula_Dia:27'
});
// http://www.isp.pt/isp/Templates/Atendimento/PesquisaVeiculoSeguro.aspx?FRAMELESS=false&NRNODEGUID=%7b09089E16-115D-4C82-9C64-FDA43D5FF098%7d&NRORIGINALURL=%2fNR%2fexeres%2f019EEB91-E357-4A7C-8BD2-B62293701692%2ehtm&NRCACHEHINT=Guest
var dataRequestOptions = {
	host : 'www.isp.pt',
	// FRAMELESS:false
	// NRNODEGUID:{09089E16-115D-4C82-9C64-FDA43D5FF098}
	// NRORIGINALURL:/NR/exeres/019EEB91-E357-4A7C-8BD2-B62293701692.htm
	// NRCACHEHINT:Guest
	path : '/isp/Templates/Atendimento/PesquisaVeiculoSeguro.aspx?FRAMELESS=false&NRNODEGUID=%7b09089E16-115D-4C82-9C64-FDA43D5FF098%7d&NRORIGINALURL=%2fNR%2fexeres%2f019EEB91-E357-4A7C-8BD2-B62293701692%2ehtm&NRCACHEHINT=Guest',
	method : 'POST',
	proxy : 'http://proxy.uminho.pt:3128',
	headers : {
		'Cookie' : 'ASP.NET_SessionId=b1lzp055bunvwu450bbhf355',
		'Content-Type' : 'application/x-www-form-urlencoded',
		'User-Agent' : 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0',
		'Content-Length' : post_data.length
	}
};
var secondRequestOptions = {
	host : 'www.isp.pt',
	port : 80,
	path : '/NR/exeres/36FAA444-8049-428C-8E89-09909A9C1300.htm?matricula=22-LB-27&data=20140327',
	headers : {
		// This cookie will be replaced by the one received on the previous
		// request
		'Cookie' : 'ASP.NET_SessionId=m34rg3j3frv1ow55ky0qdk55'
	}
};
// http://www.isp.pt/NR/exeres/36FAA444-8049-428C-8E89-09909A9C1300.htm?matricula=22-LB-27&data=20140327
var cookie = '';

var firstCallback = function(response) {
	cookie = response.headers['set-cookie'];
	if (cookie) {
		cookie = (cookie + '').split(";")[0];
		dataRequestOptions.headers['Cookie'] = cookie;
		console.log('Cookie a enviar: ' + cookie);
	}
	var body = '';
	response.on('data', function(chunk) {
		body += chunk;
	});
	response.on('end', function() {
		// console.log(body);
		var reqData = http.request(dataRequestOptions, segundoCallback);
		reqData.on('error', function(e) {
			console.log('problem with request: ' + e.message);
		});
		reqData.write(post_data);
		reqData.end();

	});
};

var segundoCallback = function(response) {
	console.log();
	var novocookie = response.headers['set-cookie'];
	if (novocookie) {
		novocookie = (novocookie + '').split(";")[0];
		secondRequestOptions.headers['Cookie'] = cookie + ';' + novocookie;
		console.log('Novo Cookie a enviar: ' + secondRequestOptions.headers['Cookie']);
	}
	secondRequestOptions.headers['Cookie'] = cookie;
	var dataBody = '';
	response.on('data', function(chunk) {
		dataBody += chunk;
	});
	response.on('end', function() {
		var secondRequest = http.request(secondRequestOptions, terceiroCallback);
		secondRequest.on('error', function(e) {
			console.log('problem with request: ' + e.message);
		});
		secondRequest.end();
	});
};

var terceiroCallback = function(response) {
	var body = '';
	response.on('data', function(chunk) {
		body += chunk;
	});
	response.on('end', function() {
		console.log(body);
	});
};

var errorCallback = function(e) {
	console.log('problem with request: ' + e.message);
};

var firstRequest = http.request(firstRequestOptions, firstCallback);
firstRequest.on('error', errorCallback);
firstRequest.end();
