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
                <xsl:value-of select="concat('http://ckan.cm-montalegre.pt/autor/', @f:id)"/>
            </xsl:attribute>
            <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@f:type"/>
                </xsl:attribute>
            </rdf:type>
            <xsl:apply-templates/>
        </rdf:Description>
    </xsl:template>
    <!--
    <f:relationship f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P2001"
        f:href="570bd656-4d5f-3304-ac81-a332a9a0f88a"/>
    <f:relationship f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P2009"
        f:href="110502f6-d289-3a77-95ac-2a67dce83c41"/>
    -->
    <xsl:template
        match="f:relationship[@f:type = 'http://iflastandards.info/ns/fr/frbr/frbrer/P2010']">
        <dct:creator>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="concat('http://ckan.cm-montalegre.pt/obra/', @f:href)"/>
            </xsl:attribute>
        </dct:creator>
    </xsl:template>
    <!-- <viaf>19303792</viaf> -->
    <xsl:template match="viaf">
        <!--
        <skos:exactMatch>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="concat('http://viaf.org/viaf/', .)"/>
            </xsl:attribute>
        </skos:exactMatch>
        -->
        <owl:sameAs>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="concat('http://viaf.org/viaf/', .)"/>
            </xsl:attribute>
        </owl:sameAs>
    </xsl:template>
    <!-- <lccn>http://www.worldcat.org/wcidentities/lccn-no98115568</lccn> -->
    <xsl:template match="lccn">
        <!--
        <skos:exactMatch>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </skos:exactMatch>
        -->
        <owl:sameAs>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </owl:sameAs>
    </xsl:template>
    <!-- <ptbnp>234800</ptbnp> -->
    <xsl:template match="ptbnp"> </xsl:template>
    <!-- <bnf>http://catalogue.bnf.fr/ark:/12148/cb11930250k</bnf> -->
    <xsl:template match="bnf">
        <!--
        <skos:exactMatch>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </skos:exactMatch>
        -->
        <owl:sameAs>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </owl:sameAs>
    </xsl:template>
    <!-- <wikipedia>http://en.wikipedia.org/wiki/Madonna_(entertainer)</wikipedia> -->
    <xsl:template match="wikipedia">
        <!--
        <skos:exactMatch>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </skos:exactMatch>
        -->
        <owl:sameAs>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="concat( 'http://pt.dbpedia.org/resource/', tokenize(., '/')[last()])"/>
            </xsl:attribute>
        </owl:sameAs>
    </xsl:template>
    <!-- <bne>http://datos.bne.es/autor/XX893212</bne> -->
    <xsl:template match="bne">
        <!--
        <skos:exactMatch>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </skos:exactMatch>
        -->
        <owl:sameAs>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </owl:sameAs>
    </xsl:template>
    <!-- <f:label>Rui Leandro Alves da Costa Maia</f:label> -->
    <xsl:template match="f:label">
        <rdfs:label>
            <xsl:value-of select="."/>
        </rdfs:label>
        <foaf:name>
            <xsl:value-of select="."/>
        </foaf:name>
    </xsl:template>
    <!-- 
      <datafield tag="700" ind1=" " ind2="1">
      <subfield code="a" f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P3039">Queiroz</subfield>
      <subfield code="b" f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P3039">Dinah
            Silveira de</subfield>
      <subfield code="f" f:type="http://iflastandards.info/ns/fr/frbr/frbrer/P3040">1911-1982</subfield>
      </datafield>
    -->
    <xsl:template match="subfield[@code = 'a']">
        <foaf:familyName>
            <xsl:value-of select="."/>
        </foaf:familyName>
    </xsl:template>
    <xsl:template match="subfield[@code = 'b']">
        <foaf:givenName>
            <xsl:value-of select="normalize-space()"/>
        </foaf:givenName>
    </xsl:template>
    <xsl:template match="subfield[@code = 'f']">
        <xsl:for-each select="tokenize(.,'-')">
            <xsl:if test="position() eq 1">
                <bio:event>
                    <bio:Birth>
                        <bio:date rdf:datatype="http://www.w3.org/2001/XMLSchema#gYear">
                            <xsl:value-of select="."/>
                        </bio:date>
                    </bio:Birth>
                </bio:event>
            </xsl:if>
            <xsl:if test="position() eq 2 and normalize-space(.)">
                <bio:event>
                    <bio:Death>
                        <bio:date rdf:datatype="http://www.w3.org/2001/XMLSchema#gYear">
                            <xsl:value-of select="."/>
                        </bio:date>
                    </bio:Death>
                </bio:event>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
