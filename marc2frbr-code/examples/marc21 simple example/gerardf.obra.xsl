<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:bibo="http://purl.org/ontology/bibo/"
    xmlns:bio="http://purl.org/vocab/bio/0.1/"
    xmlns:blt="http://www.bl.uk/schemas/bibliographic/blterms#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dct="http://purl.org/dc/terms/"
    xmlns:event="http://purl.org/NET/c4dm/event.owl#" xmlns:f="http://idi.ntnu.no/frbrizer/"
    xmlns:fabio="http://purl.org/spar/fabio/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
    xmlns:interval="http://reference.data.gov.uk/def/intervals/"
    xmlns:isbd="http://iflastandards.info/ns/isbd/elements/"
    xmlns:local="http://idi.ntnu.no/frbrizer/" xmlns:org="http://www.w3.org/ns/org#"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rda="http://rdvocab.info/ElementsGr2/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:time="http://www.w3.org/2006/time#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.loc.gov/MARC21/slim" exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="collection">
        <rdf:RDF>
            <xsl:apply-templates/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="record">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="concat('http://ckan.cm-montalegre.pt/obra/', @f:id)"/>
            </xsl:attribute>
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@f:type"/>
                </xsl:attribute>
            </rdf:type>
            <xsl:apply-templates/>
        </rdf:Description>
    </xsl:template>
    
    <!--
    <record f:id="000bc03a-b97d-3d67-8c50-bf47508a3ab9"
        f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1001">
        <datafield tag="200" ind1="1" ind2=" ">
            <subfield code="a" f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P3001">Na Crista da
                Onda</subfield>
        </datafield>
        <datafield tag="210" ind1=" " ind2=" ">
            <subfield code="d" f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P3003"
                >1999</subfield>
        </datafield>
        <f:relationship f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P2001"
            f:href="3baab893-f6c5-3919-8aec-ecffa2ba0ca2"/>
        <f:relationship f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P2009"
            f:href="51102014-a986-302b-a1a1-b6446381bb7a"/>
        <f:label/>
    </record>
    -->
    
    <xsl:template match="datafield[@tag = '200']/subfield[@code = 'a']">
        <dct:title>
            <xsl:value-of select="normalize-space()"/>
        </dct:title>
    </xsl:template>
    
    <!--       
        <datafield tag="304" ind1=" " ind2=" ">
         <subfield code="a" f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P3001">Tít. orig.:
            50 simple things kids can do to save the earth</subfield>
      </datafield>
    -->
    <!-- <dct:alternative>Songs. Selections</dct:alternative> -->
    
    <xsl:template match="datafield[@tag = '304']/subfield[@code = 'a']">
        <dct:alternative>
            <xsl:value-of select="normalize-space()"/>
        </dct:alternative>
    </xsl:template>
    
    <xsl:template match="datafield[@tag = '210']/subfield[@code = 'd']">
        <blt:publication>
            <event:time>
                <bio:date rdf:datatype="http://www.w3.org/2001/XMLSchema#gYear"><xsl:value-of select="."/></bio:date>              
            </event:time>
        </blt:publication>
    </xsl:template>

</xsl:stylesheet>
