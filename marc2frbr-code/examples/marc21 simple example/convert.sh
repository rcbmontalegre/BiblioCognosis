#!/bin/sh
export  CLASSPATH=../../jar/saxon.9.1.0.8.jar

echo "Making conversion xslt file"
java net.sf.saxon.Transform -s:unimarc.rules.xml -o:unimarc.conversion.xslt -xsl:../../xslt/make.xslt

echo "Running conversion"
# java net.sf.saxon.Transform -s:marc21.example.records.xml -o:frbr.example.records.xml -xsl:marc21.conversion.xslt
# java net.sf.saxon.Transform -s:todos-pp-1-55.xml -o:records-1-55.xml -xsl:unimarc.conversion.xslt
java net.sf.saxon.Transform -s:todos-pp.xml -o:records.xml -xsl:unimarc.conversion.xslt

