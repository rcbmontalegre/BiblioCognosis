<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://idi.ntnu.no/frbrizer/"
    xmlns:f="http://idi.ntnu.no/frbrizer/"
    xpath-default-namespace="http://www.loc.gov/MARC21/slim"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>           
        </xsl:copy>
    </xsl:template>
    
    <!-- como está comentado, os registos deste tipo serão copiados para o output
    <xsl:template match='//record[@f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1005"]'> 
    </xsl:template>
    -->
    
    <!-- não copia os tipo de registo comentados -->
    <!-- Autor -->
    <xsl:template match='//record[@f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1005"]'> 
    </xsl:template>
    <!-- Obra -->
    <xsl:template match='//record[@f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1001"]'> 
    </xsl:template>
    <!-- Expressão -->
    <xsl:template match='//record[@f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1002"]'> 
    </xsl:template>

    <!-- Manifestação -->
    <!--
    <xsl:template match='//record[@f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1003"]'> 
    </xsl:template>
    -->
    
    <!-- 
    Person: <record f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1005"
    Obra:   <record f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1001"
    Expressão: <record f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1002"
    Manifestação: <record f:type="http://iflastandards.info/ns/fr/frbr/frbrer/C1003"
    -->
    
</xsl:stylesheet>