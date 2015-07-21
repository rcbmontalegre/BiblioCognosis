var http = require("http");
var querystring = require('querystring');
var cheerio = require("cheerio");
var marc = require('marcjs'), fs = require('fs');
// https://gist.github.com/nichtich/832052
var options = {
	host : 'www.viaf.org',
	path : '/viaf/AutoSuggest?query=' + encodeURI('Zacarias Nascimento'), 
	// proxy : 'http://proxy.uminho.pt:3128',
	method : 'GET'
};
// http://www.viaf.org/viaf/AutoSuggest?query=Zacarias Nascimento
// http://www.viaf.org/viaf/AutoSuggest?query=bento%20da%20cruz
// http://www.viaf.org/viaf/AutoSuggest?query=J. H. Rosny Aîné
http.get(options, function(response) {
	if (response.statusCode == 200) {
		var dataBody = '';
		response.on('data', function(chunk) {
			dataBody += chunk;
		});
		response.on('end', function() {
			var result = JSON.parse(dataBody).result;
			// console.log(result);

			// http://viaf.org/processed/PTBNP%7C43898
			// http://viaf.org/processed/PTBNP|43898
			// http://viaf.org/viaf/69056810

			// o viaf retorna vários resultados
			// vamos ver qual deles tem a chave "ptbnp"; o primeiro que tiver essa chave, aproveita-se

			var ptbnp = null;
			var viafid = null;

			result.forEach(function(entry) {
				if (entry.ptbnp && !(ptbnp && viafid)) {
					// console.log('Interessa: ' + entry.ptbnp + ' ' + entry.viafid);
					ptbnp = entry.ptbnp;
					viafid = entry.viafid;
				}
			});
			if (ptbnp && viafid) {
				console.log('Encontrei ' + ptbnp + ' ' + 'http://viaf.org/viaf/' + viafid);
			} else {
				console.log('Não encontrei');
			}
		});
	} else {
		console.log('Problemas a sacar o registo: ' + responseNew.statusCode);
	}
}).on('error', function(e) {
	console.log('problem with request: ' + e.message);
});
