var http = require("http");
var querystring = require('querystring');
var cheerio = require("cheerio");
var marc = require('marcjs'), fs = require('fs');

// Biblioteca nacional
// formato UNIMARC
// Formato ISO2709 : registos.iso
//
// http://www.bookmarc.pt/unimarc/

// estilosASDASDADSDdDdDAdsfgddfgsdfgsdfgsdfgsdfg

var post_data_2 = querystring.stringify({
	'_ctl4:_ctl0:ddlTopFormats' : 'C:\inetpub\wwwroot\OPAC\VisualFormats\formatUnimarc.xsl'
});

// 1..16662

var reg = 1; var escritos = 0;
var w = new marc.MarcxmlWriter(fs.createWriteStream('data/todos.xml'));
// falta na primeira linha:
// <?xml version="1.0" encoding="UTF-8"?>
for ( reg = 1; reg <= 16662; reg++) {
	var dataRequestOptions = {
		host : 'montalegre.opacnet.com',
		path : '/OPAC/default.aspx?ContentAreaControl=ShowRegHoldings.ascx&RegNo=' + reg,
		method : 'POST',
		// proxy : 'http://proxy.uminho.pt:3128',
		headers : {
			'Cookie' : 'ASP.NET_SessionId=054stu55wq133ublwnyfuvaw',
			'Content-Type' : 'application/x-www-form-urlencoded',
			'User-Agent' : 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0',
			'Content-Length' : post_data_2.length
		}
	};
	var reqData = http.request(dataRequestOptions, function(responseNew) {
		// console.log(responseNew);
		if (responseNew.statusCode == 200) {
			var dataBody = '';
			responseNew.on('data', function(chunk) {
				dataBody += chunk;
				// console.log('.'); // chunk.toString());
			});
			responseNew.on('end', function() {
				// console.log(dataBody);
				// dataBody.substring(0, 400));
				var contaLinhas = 0;
				var record = new marc.Record();
				var regNo = 0;
				var $ = cheerio.load(dataBody);
				var col = '';
				// <td class="Content"
				// id="ContentData">
				$("td#ContentData.Content > div > table > tr").each(function(i, e) {
					contaLinhas += 1;
					// console.log($(e));
					var linha = cheerio.load($(e));
					// console.log('i='
					// + i + ', ' +
					// linha('td').children()
					// ); // só
					// elementos
					// console.log('i='
					// + i + ', ' +
					// linha('td').contents()
					// ); // tudo:
					// elementos,
					// text e
					// comments
					// nodes
					var field = new Array();
					linha('td').contents().each(function(j, o) {
						var log = '';
						switch (contaLinhas) {
							case 1:
								var um = linha(o).text().trim().split(' ');
								um.shift();
								regNo = um.join();
								break;
							case 2:
								record.leader = linha(o).text().trim().replace("Leader ", "");
								break;
							case 3:
								if (linha(o).text().trim() == '001') {
									field.push('001');
									field.push(regNo);
								}
								break;
							default:
								/*
								 * log +=
								 * linha(o)[0].type +
								 * '(';
								 * if
								 * (linha(o)[0].type ==
								 * 'tag') {
								 * log +=
								 * linha(o)[0].name; }
								 */
								col = linha(o).text();
								if (field.length == 1) {
									if (linha(o)[0].type == 'tag') {
										// log
										// += "
										// SEM
										// INDICADOR
										// ";
										field.push('  ');
									} else {
										// log
										// += "
										// INDICADOR:
										// ";
										field.push(col.charAt(col.length - 2) + col.charAt(col.length - 1));
									}
								} else {
									if (col.trim() != '') {
										if (col.length == 2 && col[0] == '^') {
											field.push(col[1]);
										} else {
											field.push(col.trim());
										}

									}
								}
							// log
							// +=
							// ')
							// -->
							// ' +
							// linha(o).text().trim();
							// console.log(linha(o)[0]);
						}
						// console.log(contaLinhas
						// + '
						// -->
						// ' +
						// linha(o).text());
					});
					if (field.length)
						record.append(field);
				});
				// Estou a fazer como faz a biblioteca nacional
				var campos = record.fields.map(function(f) {
					return f[0];
				});
				// console.log(campos);
				if (campos.indexOf('003') < 0) {
					// console.log('Não tem o campo 003');
					record.append(['003', 'http://' + dataRequestOptions.host + dataRequestOptions.path]);
				}
				console.log('.' + regNo);
				// console.log(JSON.stringify(record));
				// console.log(JSON.stringify(record.toMiJ()));

				/*
				var writers = [
					new marc.JsonWriter(fs.createWriteStream('data/json/' + regNo + '.json')), 
					new marc.MarcxmlWriter(fs.createWriteStream('data/XML/' + regNo + '.xml')), 
					new marc.Iso2709Writer(fs.createWriteStream('data/ISO2709/' + regNo + '.mrc')), 
					new marc.TextWriter(fs.createWriteStream('data/unimarc/' + regNo + '.txt'))];

				writers.forEach(function(writer) {
					writer.write(record);
				});
				writers.forEach(function(writer) {
					writer.end();
				});
				*/
				
				w.write(record, function() {
					escritos = escritos +1;
					// console.log('w.write ' +  escritos);
					if (escritos == (16662-1)+1) {
						w.end();
					}
				});
			});
		} else {
			console.log('Problemas a obter o registo: ' + responseNew.statusCode);
		}
	});
	reqData.on('error', function(e) {
		console.log('problem with request: ' + e.message);
	});
	reqData.write(post_data_2);
	reqData.end();
}
