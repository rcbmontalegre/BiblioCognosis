/**
 * New node file
 */
var marc = require('marcjs'), fs = require('fs');

// var reader = new marc.Iso2709Reader(fs.createReadStream('bib.mrc'));
// var reader = new marc.Iso2709Reader(fs.createReadStream('data/16163.mrc'));
//var reader = new marc.Iso2709Reader(fs.createReadStream('registos.iso'));
var reader = new marc.MarcxmlReader(fs.createReadStream('RegMarcXchange.xml'));

var writers = [ new marc.JsonWriter(fs.createWriteStream('bib-out.json')),
		new marc.MarcxmlWriter(fs.createWriteStream('bib-out.xml')),
		new marc.Iso2709Writer(fs.createWriteStream('bib-out.mrc')),
		new marc.TextWriter(fs.createWriteStream('bib-out.txt')) 
];

var result;

reader.on('data', function(record) {
    result = record;
});

reader.on('end', function(){
	writers.forEach(function(writer) {
		// writer.write(result, 'UTF-8', function(){ console.log('Viva o Gustavo');});
		writer.write(result);
	});
	writers.forEach(function(writer) {
		writer.end();
	});
	console.log(JSON.stringify(result));
});

/*
var result = {
      leader: '00711nam  2200217   4500',
      fields: [
        { '010': { ind1: ' ', ind2: ' ', subfields: [ { a: '2-07-074244-X' }, { b: 'br.' }, { d: '98 F' } ] } },
        { '020': { ind1: ' ', ind2: ' ', subfields: [ { a: 'FR' }, { b: '09607512' } ] } },
        { '100': { ind1: ' ', ind2: ' ', subfields: [ { a: '19960212d1995    m  y0frey50      ba' } ] } },
        { '101': { ind1: '0', ind2: ' ', subfields: [ { a: 'fre' } ] } },
        { '102': { ind1: ' ', ind2: ' ', subfields: [ { a: 'FR' } ] } },
        { '105': { ind1: ' ', ind2: ' ', subfields: [ { a: '    z   00 a ' } ] } },
        { '106': { ind1: ' ', ind2: ' ', subfields: [ { a: 'r' } ] } },
        { '200': { ind1: '1', ind2: ' ', subfields: [ { a: 'Ici' }, { b: 'Texte imprimé' }, { f: 'Nathalie Sarraute' } ] } },
        { '210': { ind1: ' ', ind2: ' ', subfields: [ { a: '[Paris]' }, { c: 'Gallimard' }, { d: '1995' }, { e: '53-Mayenne' }, { g: 'Impr. Floch' } ] } },
        { '215': { ind1: ' ', ind2: ' ', subfields: [ { a: '181 p.' }, { d: '21 cm' } ] } },
        { '517': '1 ' },
        { '676': { ind1: ' ', ind2: ' ', subfields: [ { a: '843.91' }, { v: '22' } ] } },
        { '686': { ind1: ' ', ind2: ' ', subfields: [ { a: '823' }, { 2: 'Cadre de classement de la Bibliographie nationale française' } ] } },
        { '700': { ind1: ' ', ind2: '|', subfields: [ { a: 'Sarraute' }, { b: 'Nathalie' }, { f: '1900-1999' }, { 4: '070' } ] } },
        { '801': { ind1: ' ', ind2: '0', subfields: [ { a: 'FR' }, { b: 'FR-751131015' }, { c: '19960212' }, { g: 'AFNOR' }, { h: 'FRBNF357901120000000' }, { 2: 'intermrc' } ] } },
        { '995': { ind1: ' ', ind2: ' ', subfields: [ { a: 'BEAU' }, { b: 'BEAU' }, { c: 'BEAU' }, { e: 'a' }, { f: '2000100014080' }, { k: 'R SAR' }, { o: '0' }, { r: 'LIVR' } ] } }
      ]
};
*/




