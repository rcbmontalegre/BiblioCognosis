from pymarc import MARCReader, Record, Field
# reader = MARCReader(open('marc.harrypotter.txt'))
# reader = MARCReader(open('gib.iso'))
reader = MARCReader(open('16163.mrc'), to_unicode=True, force_utf8=True)
for record in reader: 
	# print record.title()
	print record['200']['a']
