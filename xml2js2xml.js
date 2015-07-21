var fs = require('fs'),
    xml2js = require('xml2js'),
    util = require('util'),
    xpath = require('xpath'),
    dom = require('xmldom').DOMParser,
    inspect = require('eyes').inspector({
        maxLength: false
    }),
    http = require("http");

var parser = new xml2js.Parser();
var builder = new xml2js.Builder();

// variáveis global
var recursos;
var pessoa = [];
var pedidos = 0;

// var entrada = __dirname + '/marc2frbr-code/examples/marc21 simple example/records-1-55.xml';
// var entrada = __dirname + '/marc2frbr-code/examples/marc21 simple example/records.xml';
var entrada = __dirname + '/marc2frbr-code/examples/marc21 simple example/autor.xml';

// var saida = __dirname + '/marc2frbr-code/examples/marc21 simple example/records-1-55-extra-fev.xml';
var saida = __dirname + '/marc2frbr-code/examples/marc21 simple example/autor-extra.xml';

function termina() {
    pedidos--;
    console.log('----------------Termina: ' + pedidos + '--------------------------');
    if (pedidos == 0) {
        // console.dir(pessoa);
        // console.log(pessoa.length);
        // console.log(recursos.collection.record.length);

        recursos.collection.record.forEach(function (element, index, array) {
            var a = element.$['f:type'].split('/');
            var type = a[a.length - 1];
            switch (type) {
                case 'C1005': // Person/Pessoa
                    element.extra = pessoa[index];
                    break;
                case 'C1001': // Work/Obra
                    break;
                case 'C1002': // Expression/Expressão
                    break;
                case 'C1003': // Manifestation
                    break;
                default:
                    break;
            }
        });
        var xml = builder.buildObject(recursos);
        fs.writeFile(saida, xml, function (err) {
            if (err) throw err;
            console.log('Terminou!');
        });
    }
};

function recolhe_dados_viaf(viafid, e, callback) {
    pedidos++;
    var options = {
        // http://viaf.org/viaf/17228936/justlinks.json
        // http://www.viaf.org/viaf/69056810/justlinks.json // Bento da Cruz
        // http://www.viaf.org/viaf/56629516/justlinks.json // Sophia_de_Mello_Breyner_Andresen
        // http://www.freebase.com/m/03bbxp // freebase.com // without children
        host: 'viaf.org',
        path: '/viaf/' + viafid + '/justlinks.json',
        method: 'GET'
    };
    http.get(options, function (response) {
        if (response.statusCode == 200) {
            var dataBody = '';
            response.on('data', function (chunk) {
                dataBody += chunk;
            });
            response.on('end', function () {
                try {
                    var result = JSON.parse(dataBody);
                    if (result) {
                        console.log('Sacar o VIAFID = ' + viafid);
                        // console.log('http://www.worldcat.org/wcidentities/lccn-' + result['LC']);
                        // console.log('http://en.wikipedia.org/wiki/' + result['WKP']);

                        if (result['WKP'])
                            e.wikipedia = 'http://en.wikipedia.org/wiki/' + result['WKP'];
                        if (result['LC'])
                            e.lccn = 'http://www.worldcat.org/wcidentities/lccn-' + result['LC'];
                        if (result['BNE'])
                            e.bne = 'http://datos.bne.es/autor/' + result['BNE'];
                        if (result['BNF'])
                            if (result['BNF'].constructor === Array)
                                e.bnf = result['BNF'][0];
                    } else {
                        console.log('ERRO 2----------------------------');
                        console.log(options.path);
                    }
                } catch (e) {
                    console.log('ERRO 3---------------------------------------------------------');
                } finally {
                    callback();
                }
            });
        } else {
            console.log('Problemas a sacar o registo: ' + response.statusCode);
            callback();
        }
    }).on('error', function (e) {
        console.log('problem with request: ' + e.message);
        callback();
    });
};

function recolhe_informacao_autor(autor, el, callback) {
    var options = {
        host: 'www.viaf.org',
        path: '/viaf/AutoSuggest?query=' + encodeURI(autor),
        // proxy : 'http://proxy.uminho.pt:3128',
        method: 'GET'
    };
    // http://www.viaf.org/viaf/AutoSuggest?query=Zacarias Nascimento
    // http://www.viaf.org/viaf/AutoSuggest?query=bento%20da%20cruz
    // http://www.viaf.org/viaf/AutoSuggest?query=J. H. Rosny Aîné
    http.get(options, function (response) {
        if (response.statusCode == 200) {
            var dataBody = '';
            response.on('data', function (chunk) {
                dataBody += chunk;
            });
            response.on('end', function () {
                try {
                    var result = JSON.parse(dataBody).result;
                    if (result) {
                        // console.log(result);
                        // http://viaf.org/processed/PTBNP%7C43898
                        // http://viaf.org/processed/PTBNP|43898
                        // http://viaf.org/viaf/69056810
                        // o viaf retorna vários resultados
                        // vamos ver qual deles tem a chave "ptbnp"; o primeiro que tiver essa chave, aproveita-se
                        var ptbnp = null;
                        var viafid = null;
                        var term = null;
                        result.forEach(function (entry) {
                            if (entry.ptbnp && !(ptbnp && viafid)) {
                                // console.log('Interessa: ' + entry.ptbnp + ' ' + entry.viafid);
                                ptbnp = entry.ptbnp;
                                viafid = entry.viafid;
                                term = entry.term;
                            }
                        });
                        if (ptbnp && viafid) {
                            // console.log('Para o autor ' + autor + ' encontrei o ID PT ' + ptbnp + ' e o VIAF ID ' + 'http://viaf.org/viaf/' + viafid);
                            el.ptbnp = ptbnp;
                            el.viaf = viafid;
                            recolhe_dados_viaf(viafid, el, callback);
                        } else {
                            console.log('Não encontrei, pelo que não invoca o termina...');
                        }
                    } else {
                        console.log('ERRO 1----------------------------');
                        console.log(options.path);
                    }
                } catch (e) {
                    console.log('ERRO 4---------------------------------------------------------');
                }
            });
        } else {
            console.log('Problemas a sacar o registo: ' + response.statusCode);
        }
    }).on('error', function (e) {
        console.log('problem with request: ' + e.message);
    });
};

fs.readFile(entrada, function (err, data) {
// fs.readFile(__dirname + '/marc2frbr-code/examples/marc21 simple example/records.xml', function (err, data) {
    parser.parseString(data, function (err, result) {
        recursos = result;
        var contador = {'pessoa': 0, 'obra': 0, 'expressao': 0, 'manifestacao': 0, 'outros': 0};
        result.collection.record.forEach(function (element, index, array) {
            var a = element.$['f:type'].split('/');
            var type = a[a.length - 1];
            pessoa[index] = {};
            switch (type) {
                case 'C1005': // Person/Pessoa
                    var nome = element['f:label'];
                    // console.log('record[' + index + '] = ' + nome);
                    if (nome)
                        recolhe_informacao_autor(nome, pessoa[index], termina);
                    else
                        console.log('ERRO: Pessoa sem nome');
                    contador.pessoa++;
                    break;
                case 'C1001': // Work/Obra
                    // console.log('record[' + index + '] = ' + type);
                    contador.obra++;
                    break;
                case 'C1002': // Expression/Expressão
                    // console.log('record[' + index + '] = ' + type);
                    contador.expressao++;
                    break;
                case 'C1003': // Manifestation
                    // console.log('record[' + index + '] = ' + type);
                    contador.manifestacao++;
                    break;
                default:
                    // console.log('record[' + index + '] = ' + type);
                    contador.outros++;
                    break;
            }
        });
        console.dir(contador);
    });
});