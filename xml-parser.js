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

	for (var i = 0; i < nodes.length; i++) {
		var apelido = xpath.select('./subfield[@code="a"]/text()', nodes[i])[0].data;
		var nomeproprio = xpath.select('./subfield[@code="b"]/text()', nodes[i])[0].data;
		var nome = nomeproprio + ' ' + apelido;
		console.log('Vamos pesquisar o ID do autor: ' + nome);
	}

	// criar um array com o autor x viaf
	// se o autor já esiver no array, é escusado pesquisar no VIAF novamente, né?	

});

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