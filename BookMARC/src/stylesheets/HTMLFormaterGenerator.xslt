<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias" xmlns:marc="http://www.loc.gov/MARC21/slim">
<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml"/>

<xsl:template match="/">
  <!-- Stylesheet Header -->
  <axsl:stylesheet version="1.0" xmlns:marc="http://www.loc.gov/MARC21/slim">
    <xsl:element name="xsl:output">
      <xsl:attribute name="method">html</xsl:attribute>
    </xsl:element>

    <xsl:call-template name="Root"/>
    <xsl:call-template name="Leader"/>
    <xsl:call-template name="Controlfield"/>
    <xsl:call-template name="Datafield"/>
    <xsl:call-template name="Unknown"/>
  </axsl:stylesheet>	
  <!-- Stylesheet Header End -->
</xsl:template>

<!-- Root Template -->
<xsl:template name="Root">
  <xsl:element name="xsl:template">
    <xsl:attribute name="match">/</xsl:attribute>
    
    <html>
      <head>
        <title></title>
      </head>
      <body style="font-family: Verdana, Helvetica, Arial, Sans-Serif">
        <xsl:element name="xsl:apply-templates"/>
      </body>
    </html>
  </xsl:element>
</xsl:template>
<!-- Root Template End -->

<!-- Leader Template -->
<xsl:template name="Leader">
  <xsl:element name="xsl:template">
    <xsl:attribute name="match">marc:leader</xsl:attribute>

    <p>LEADER</p>

    <xsl:element name="xsl:variable">
      <xsl:attribute name="name">leader</xsl:attribute>
      <xsl:attribute name="select">text()</xsl:attribute>
    </xsl:element>
    
    <xsl:for-each select="format-description/files/file">
      <xsl:variable name="file" select="text()"/>
    
      <ul>
        <xsl:for-each select="document($file)/FORMAT/LEADER/node()[@start]">
          <li>
            <xsl:value-of select="@name"/>
            <xsl:text>: </xsl:text>
            <xsl:element name="xsl:value-of">
              <xsl:attribute name="select">substring($leader, <xsl:value-of select="@start"/>, <xsl:value-of select="@length"/>)</xsl:attribute>
            </xsl:element>
          </li>
        </xsl:for-each>
      </ul>
    </xsl:for-each>
  </xsl:element>
</xsl:template>
<!-- Leader Template End -->

<!-- Controlfield Template -->
<xsl:template name="Controlfield">
  <xsl:for-each select="format-description/files/file">
    <xsl:variable name="file" select="text()"/>
    
    <xsl:for-each select="document($file)/FORMAT/FIELD">
      <xsl:variable name="tag" select="@tag"/>
  
      <xsl:if test="starts-with($tag, '00') and not(contains($tag, '-'))">
        <xsl:element name="xsl:template">
          <xsl:attribute name="match">marc:controlfield[@tag = <xsl:value-of select="$tag"/>]</xsl:attribute>
  
          <p><xsl:value-of select="@name"/></p>
          <ul type="square">
            <li>
              <xsl:element name="xsl:value-of">
                <xsl:attribute name="select">text()</xsl:attribute>
              </xsl:element>
            </li>
          </ul>
        </xsl:element>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>
<!-- Controlfield Template End -->

<!-- Datafield Template -->
<xsl:template name="Datafield">
  <xsl:for-each select="format-description/files/file">
    <xsl:variable name="file" select="text()"/>
    
    <xsl:for-each select="document($file)/FORMAT/FIELD">
      <xsl:variable name="tag" select="@tag"/>
  
      <xsl:if test="not(starts-with($tag, '00')) and not(contains($tag, '-'))">
        <xsl:element name="xsl:template">
          <xsl:attribute name="match">marc:datafield[@tag = <xsl:value-of select="$tag"/>]</xsl:attribute>
  
          <p><xsl:value-of select="@name"/></p>
          <ul>
            <xsl:for-each select="SUBFIELD">
              <xsl:variable name="code" select="@tag"/>
  
              <xsl:element name="xsl:for-each">
                <xsl:attribute name="select">marc:subfield[@code = '<xsl:value-of select="$code"/>']</xsl:attribute>
  
                <li>
                  <xsl:value-of select="@name"/>:
                  <xsl:element name="xsl:value-of">
                    <xsl:attribute name="select">text()</xsl:attribute>
                  </xsl:element>
                </li>
              </xsl:element>
            </xsl:for-each>
          </ul>
        </xsl:element>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>
<!-- DatafieldDetail Template End -->

<!--
Unknown Fields Template
-->
<xsl:template name="Unknown">
  <xsl:element name="xsl:template">
    <xsl:attribute name="priority">-1</xsl:attribute>
    <xsl:attribute name="match">marc:controlfield</xsl:attribute>
  
    <font color="#ff0000">
      <p>CONTROLFIELD NOT DESCRIBED IN THE MANUAL</p>
    </font>
    <ul>
      <li>
        <xsl:element name="xsl:value-of">
          <xsl:attribute name="select">@tag</xsl:attribute>
        </xsl:element>
        <xsl:text> : </xsl:text>
        <xsl:element name="xsl:value-of">
          <xsl:attribute name="select">text()</xsl:attribute>
        </xsl:element>
      </li>
    </ul>
  </xsl:element>
  
  <xsl:element name="xsl:template">
    <xsl:attribute name="priority">-1</xsl:attribute>
    <xsl:attribute name="match">marc:datafield</xsl:attribute>
  
    <font color="#ff0000">
      <p>DATAFIELD NOT DESCRIBED IN THE MANUAL</p>
    </font>
    <ul>
      <li>
        <xsl:element name="xsl:value-of">
          <xsl:attribute name="select">@tag</xsl:attribute>
        </xsl:element>
      </li>
    </ul>
  </xsl:element>
</xsl:template>
<!-- Unknown Fields Template End -->
</xsl:stylesheet>