var http = require("http");
var querystring = require('querystring');
var cheerio = require("cheerio");
var marc = require('marcjs'), fs = require('fs');
var fs = require('fs'),
// xml2js = require('xml2js'),
util = require('util'), xpath = require('xpath'), dom = require('xmldom').DOMParser, inspect = require('eyes').inspector({
	maxLength : false
});

// http://www.ifla.org/files/assets/uca/Unimarc_bib_3%C2%AAed_abrev.pdf
// campo 700

// var parser = new xml2js.Parser();
fs.readFile(__dirname + '/data/todos-pp-1-55.xml', function(err, data) {

	var doc = new dom().parseFromString(data.toString());
	var nodes = xpath.select('//record/datafield[@tag="700"]', doc);
	var nome = '';

	for (var i = 0; i < nodes.length; i++) {
		var apelido = xpath.select('./subfield[@code="a"]/text()', nodes[i])[0].data;
		var nomeproprio = xpath.select('./subfield[@code="b"]/text()', nodes[i])[0].data;
		var nome = nomeproprio + ' ' + apelido;
		// console.log('Vamos pesquisar o ID do autor: ' + nome);

		(function(autor) {
			var options = {
				host : 'www.viaf.org',
				path : '/viaf/AutoSuggest?query=' + encodeURI(autor),
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
						var term = null;

						result.forEach(function(entry) {
							if (entry.ptbnp && !(ptbnp && viafid)) {
								// console.log('Interessa: ' + entry.ptbnp + ' ' + entry.viafid);
								ptbnp = entry.ptbnp;
								viafid = entry.viafid;
								term = entry.term;
							}
						});
						if (ptbnp && viafid) {
							console.log('Para o autor ' + autor + ' encontrei o ID PT ' + ptbnp + ' e o VIAF ID ' + 'http://viaf.org/viaf/' + viafid);

							(function(viafid, autor) {
								var options = {
									// http://viaf.org/viaf/17228936/justlinks.json
									host : 'viaf.org',
									path : '/viaf/' + viafid + '/justlinks.json',
									method : 'GET'
								};
								http.get(options, function(response) {
									if (response.statusCode == 200) {
										var dataBody = '';
										response.on('data', function(chunk) {
											dataBody += chunk;
										});
										response.on('end', function() {
											var result = JSON.parse(dataBody);
											console.log('Sacar o VIAFID = ' + viafid + ' ' + autor);
											console.log('http://www.worldcat.org/wcidentities/lccn-' + result['LC']);
											console.log('http://en.wikipedia.org/wiki/' + result['WKP']);
										});
									} else {
										console.log('Problemas a sacar o registo: ' + response.statusCode);
									}
								}).on('error', function(e) {
									console.log('problem with request: ' + e.message);
								});

							})(viafid, autor);

						} else {
							console.log('Não encontrei');
						}
					});
				} else {
					console.log('Problemas a sacar o registo: ' + response.statusCode);
				}
			}).on('error', function(e) {
				console.log('problem with request: ' + e.message);
			});

		})(nome);

	}
	// criar um array com o autor x viaf
	// se o autor já esiver no array, é escusado pesquisar no VIAF novamente, né?

});

// VIAF + Wikipédia

// VIAF + OCLS WorldCat

// http://www.viaf.org/viaf/sourceID/WKP%7CJ.-H._Rosny_a%C3%AEn%C3%A9
// http://viaf.org/viaf/17228936/justlinks.json

// WKP: [ "J.-H._Rosny_aÃ®nÃ©" ]
// http://en.wikipedia.org/wiki/J.-H._Rosny_a%C3%AEn%C3%A9

// http://wses.wordpress.com/que-es/foaf/

/*
 <?xml version="1.0" encoding="UTF-8"?>
 <rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
 xmlns:foaf="http://xmlns.com/foaf/0.1/"
 xmlns:admin="http://webns.net/mvcb/">
 <foaf:Person rdf:ID="12345">
 <foaf:name>J. H. Rosny Aîné</foaf:name>
 <foaf:givenname>J. H. Rosny</foaf:givenname>
 <foaf:family_name>Aîné</foaf:family_name>
 </foaf:Person>
 </rdf:RDF>
 */
