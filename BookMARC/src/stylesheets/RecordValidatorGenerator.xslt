<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias" xmlns:marc="http://www.loc.gov/MARC21/slim">
  <xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
  
  <xsl:output method="xml"/>
  
  <xsl:template match="/">
    <!-- 
    Stylesheet Header 
    -->
    <axsl:stylesheet xmlns:marc="http://www.loc.gov/MARC21/slim">
      <xsl:attribute name="version">1.1</xsl:attribute>
      <xsl:element name="xsl:output">
        <xsl:attribute name="method">xml</xsl:attribute>
        <xsl:attribute name="encoding">UTF-8</xsl:attribute>
      </xsl:element>
      <xsl:element name="xsl:preserve-space">
        <xsl:attribute name="elements">*</xsl:attribute>
      </xsl:element>
      
      <!-- 
      validateDatafield Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">validateDatafield</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">isObsolete</xsl:attribute>
          <xsl:attribute name="select">false()</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">sCodesNR</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">sCodesR</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">i1Values</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">i2Values</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">$isObsolete=true()</xsl:attribute>
          <warning type="ObsoleteTag">
            <xsl:element name="xsl:copy-of">
              <xsl:attribute name="select">.</xsl:attribute>
            </xsl:element>
          </warning>
        </xsl:element>
        <xsl:element name="xsl:call-template">
          <xsl:attribute name="name">checkNRSubfields</xsl:attribute>
          <xsl:element name="xsl:with-param">
            <xsl:attribute name="name">sCodesNR</xsl:attribute>
            <xsl:attribute name="select">$sCodesNR</xsl:attribute>
          </xsl:element>
        </xsl:element>
        <xsl:element name="xsl:call-template">
          <xsl:attribute name="name">validateSubfields</xsl:attribute>
          <xsl:element name="xsl:with-param">
            <xsl:attribute name="name">sCodes</xsl:attribute>
            <xsl:attribute name="select">concat($sCodesR, $sCodesNR)</xsl:attribute>
          </xsl:element>
        </xsl:element>
        <xsl:element name="xsl:call-template">
          <xsl:attribute name="name">validateIndicator1</xsl:attribute>
          <xsl:element name="xsl:with-param">
            <xsl:attribute name="name">iValues</xsl:attribute>
            <xsl:attribute name="select">$i1Values</xsl:attribute>
          </xsl:element>
        </xsl:element>
        <xsl:element name="xsl:call-template">
          <xsl:attribute name="name">validateIndicator2</xsl:attribute>
          <xsl:element name="xsl:with-param">
            <xsl:attribute name="name">iValues</xsl:attribute>
            <xsl:attribute name="select">$i2Values</xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <!-- validateDatafield Template End -->
      
      <!-- 
      checkNRSubfields Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">checkNRSubfields</xsl:attribute>

        <xsl:element name="xsl:param">
          <xsl:attribute name="name">sCodesNR</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">$sCodesNR</xsl:attribute>
          <xsl:element name="xsl:if">
          <xsl:attribute name="test">count(marc:subfield[@code=substring($sCodesNR, 1, 1)]) &gt; 1</xsl:attribute>
            <error type="NonRepeatableSubfieldRepeats">
              <xsl:attribute name="tagID">{generate-id(.)}</xsl:attribute>
              <code>
                <xsl:element name="xsl:value-of">
                  <xsl:attribute name="select">@code</xsl:attribute>
                </xsl:element>
              </code>
            </error>
          </xsl:element>
          <xsl:element name="xsl:call-template">
            <xsl:attribute name="name">checkNRSubfields</xsl:attribute>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name">sCodesNR</xsl:attribute>
              <xsl:attribute name="select">substring($sCodesNR, 2)</xsl:attribute>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <!-- checkNRSubfields Template End -->
      
      <!-- 
      validateSubfields Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">validateSubfields</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">sCodes</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:for-each">
        <xsl:attribute name="select">marc:subfield</xsl:attribute>

          <xsl:element name="xsl:if">
            <xsl:attribute name="test">not(contains($sCodes, @code))</xsl:attribute>
            <error type="InvalidSubfieldCode">
              <xsl:attribute name="tagID">{generate-id(.)}</xsl:attribute>
              <code>
                <xsl:element name="xsl:value-of">
                  <xsl:attribute name="select">@code</xsl:attribute>
                </xsl:element>
              </code>
            </error>
          </xsl:element>
          
          <!-- validate embedded fields -->
          <xsl:element name="xsl:if">
			  <xsl:attribute name="test">count(marc:embedded) > 0</xsl:attribute>
			  <xsl:element name="xsl:apply-templates">
				  <xsl:attribute name="select">marc:embedded/marc:datafield</xsl:attribute>
			  </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <!-- validateSubfields Template End -->
      
      <!-- 
      validateIndicator1 Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">validateIndicator1</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">iValues</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">($iValues != @ind1) and not(contains($iValues, @ind1))</xsl:attribute>
          <xsl:element name="xsl:if">
            <xsl:attribute name="test">substring-before($iValues, '-') > @ind1 or substring-after($iValues, '-') &lt; @ind1</xsl:attribute>
            <error type="InvalidIndicator" i1="">
              <xsl:element name="xsl:copy-of">
                <xsl:attribute name="select">.</xsl:attribute>
              </xsl:element>
            </error>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <!-- validateIndicator1 Template End -->
      
      <!-- 
      validateIndicator2 Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">validateIndicator2</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">iValues</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">($iValues != @ind2) and not(contains($iValues, @ind2))</xsl:attribute>
          <xsl:element name="xsl:if">
            <xsl:attribute name="test">substring-before($iValues, '-') > @ind2 or substring-after($iValues, '-') &lt; @ind2</xsl:attribute>
            <error type="InvalidIndicator" i2="">
              <xsl:element name="xsl:copy-of">
                <xsl:attribute name="select">.</xsl:attribute>
              </xsl:element>
            </error>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <!-- validateIndicator2 Template End -->
      
      <!-- 
      validatePSubfield Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">validatePSubfield</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">start</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">end</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">vocabulary</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">count($vocabulary/vocabulary/child::node()) &gt; 0</xsl:attribute>
          <xsl:element name="xsl:variable">
            <xsl:attribute name="name">fieldValue</xsl:attribute>
            <xsl:element name="xsl:value-of">
              <xsl:attribute name="select">.</xsl:attribute>
            </xsl:element>
          </xsl:element>
          <xsl:element name="xsl:variable">
            <xsl:attribute name="name">psValue</xsl:attribute>
            <xsl:element name="xsl:value-of">
              <xsl:attribute name="select">substring($fieldValue, $start + 1, $end - $start + 1)</xsl:attribute>
            </xsl:element>
          </xsl:element>
          <xsl:element name="xsl:choose">
            <xsl:element name="xsl:when">
              <xsl:attribute name="test">count($vocabulary/vocabulary/ITEM[@code = $psValue]) &gt; 0</xsl:attribute>
            </xsl:element>
            <xsl:element name="xsl:when">
              <xsl:attribute name="test">string-length($psValue > 1)</xsl:attribute>
              <xsl:element name="xsl:variable">
                <xsl:attribute name="name">error</xsl:attribute>
                <xsl:element name="xsl:call-template">
                  <xsl:attribute name="name">checkPSValue</xsl:attribute>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">psValue</xsl:attribute>
                    <xsl:attribute name="select">$psValue</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">vocabulary</xsl:attribute>
                    <xsl:attribute name="select">$vocabulary</xsl:attribute>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              <xsl:element name="xsl:if">
                <xsl:attribute name="test">not(contains($error, 't'))</xsl:attribute>
                <xsl:element name="xsl:call-template">
                  <xsl:attribute name="name">generatePSubfieldError</xsl:attribute>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">fieldValue</xsl:attribute>
                    <xsl:attribute name="select">$fieldValue</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">start</xsl:attribute>
                    <xsl:attribute name="select">$start</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">end</xsl:attribute>
                    <xsl:attribute name="select">$end</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">vocabulary</xsl:attribute>
                    <xsl:attribute name="select">$vocabulary</xsl:attribute>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
            </xsl:element>
            <xsl:element name="xsl:when">
              <xsl:attribute name="test">count($vocabulary/vocabulary/ITEM[@type = 'range']) &gt; 0</xsl:attribute>
              <xsl:element name="xsl:variable">
                <xsl:attribute name="name">error</xsl:attribute>
                <xsl:element name="xsl:for-each">
                  <xsl:attribute name="select">$vocabulary/vocabulary/ITEM[@type = 'range']</xsl:attribute>
                  <xsl:element name="xsl:call-template">
                    <xsl:attribute name="name">checkRangeCode</xsl:attribute>
                    <xsl:element name="xsl:with-param">
                      <xsl:attribute name="name">psValue</xsl:attribute>
                      <xsl:attribute name="select">$psValue</xsl:attribute>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              <xsl:element name="xsl:if">
                <xsl:attribute name="test">not(contains($error, 't'))</xsl:attribute>
                <xsl:element name="xsl:call-template">
                  <xsl:attribute name="name">generatePSubfieldError</xsl:attribute>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">fieldValue</xsl:attribute>
                    <xsl:attribute name="select">$fieldValue</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">start</xsl:attribute>
                    <xsl:attribute name="select">$start</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">end</xsl:attribute>
                    <xsl:attribute name="select">$end</xsl:attribute>
                  </xsl:element>
                  <xsl:element name="xsl:with-param">
                    <xsl:attribute name="name">vocabulary</xsl:attribute>
                    <xsl:attribute name="select">$vocabulary</xsl:attribute>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
            </xsl:element>
            <xsl:element name="xsl:otherwise">
              <xsl:element name="xsl:call-template">
                <xsl:attribute name="name">generatePSubfieldError</xsl:attribute>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">fieldValue</xsl:attribute>
                  <xsl:attribute name="select">$fieldValue</xsl:attribute>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">start</xsl:attribute>
                  <xsl:attribute name="select">$start</xsl:attribute>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">end</xsl:attribute>
                  <xsl:attribute name="select">$end</xsl:attribute>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">vocabulary</xsl:attribute>
                  <xsl:attribute name="select">$vocabulary</xsl:attribute>
                </xsl:element>
              </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <!-- validatePSubfield Template -->
      
      <!-- 
      checkPSValue Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">checkPSValue</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">psValue</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">vocabulary</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:variable">
          <xsl:attribute name="name">value</xsl:attribute>
          <xsl:attribute name="select">substring($psValue, 1, 1)</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">$psValue</xsl:attribute>
          <xsl:element name="xsl:choose">
            <xsl:element name="xsl:when">
              <xsl:attribute name="test">count($vocabulary/vocabulary/ITEM[@code = $value]) &gt; 0</xsl:attribute>
            t
          </xsl:element>
            <xsl:element name="xsl:when">
              <xsl:attribute name="test">count($vocabulary/vocabulary/ITEM[@type = 'range']) &gt; 0</xsl:attribute>
              <xsl:element name="xsl:variable">
                <xsl:attribute name="name">error</xsl:attribute>
                <xsl:element name="xsl:for-each">
                  <xsl:attribute name="select">$vocabulary/vocabulary/ITEM[@type = 'range']</xsl:attribute>
                  <xsl:element name="xsl:call-template">
                    <xsl:attribute name="name">checkRangeCode</xsl:attribute>
                    <xsl:element name="xsl:with-param">
                      <xsl:attribute name="name">psValue</xsl:attribute>
                      <xsl:attribute name="select">$psValue</xsl:attribute>
                    </xsl:element>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              <xsl:element name="xsl:if">
                <xsl:attribute name="test">contains($error, 't')</xsl:attribute>
              t
            </xsl:element>
              <xsl:element name="xsl:if">
                <xsl:attribute name="test">not(contains($error, 't'))</xsl:attribute>
              f
            </xsl:element>
            </xsl:element>
            <xsl:element name="xsl:otherwise">f</xsl:element>
          </xsl:element>
          <xsl:element name="xsl:call-template">
            <xsl:attribute name="name">checkPSValue</xsl:attribute>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name">psValue</xsl:attribute>
              <xsl:attribute name="select">substring($psValue, 2)</xsl:attribute>
            </xsl:element>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name">vocabulary</xsl:attribute>
              <xsl:attribute name="select">$vocabulary</xsl:attribute>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
      <!--checkPSValue Template End -->
      
      <!-- 
      checkRangeCode Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">checkRangeCode</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">psValue</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">($psValue &gt;= substring-before(@code, '-')) and ($psValue &lt;= substring-after(@code, '-'))</xsl:attribute>
        t
      </xsl:element>
        <xsl:element name="xsl:if">
          <xsl:attribute name="test">($psValue &lt; substring-before(@code, '-')) or ($psValue &gt; substring-after(@code, '-'))</xsl:attribute>
        f
      </xsl:element>
      </xsl:element>
      <!-- checkRangeCode End -->
      
      <!-- 
      generatePSubfieldError Template 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">generatePSubfieldError</xsl:attribute>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">fieldValue</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">start</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">end</xsl:attribute>
        </xsl:element>
        <xsl:element name="xsl:param">
          <xsl:attribute name="name">vocabulary</xsl:attribute>
        </xsl:element>
        <error type="InvalidPSubfield">
          <field>
            <xsl:element name="xsl:attribute">
              <xsl:attribute name="name">tag</xsl:attribute>
              <xsl:element name="xsl:value-of">
                <xsl:attribute name="select">@tag</xsl:attribute>
              </xsl:element>
            </xsl:element>
            <xsl:element name="xsl:attribute">
              <xsl:attribute name="name">start</xsl:attribute>
              <xsl:element name="xsl:value-of">
                <xsl:attribute name="select">$start</xsl:attribute>
              </xsl:element>
            </xsl:element>
            <xsl:element name="xsl:attribute">
              <xsl:attribute name="name">end</xsl:attribute>
              <xsl:element name="xsl:value-of">
                <xsl:attribute name="select">$end</xsl:attribute>
              </xsl:element>
            </xsl:element>
            <invalid>
              <xsl:element name="xsl:value-of">
                <xsl:attribute name="select">substring($fieldValue, $start + 1, $end - $start + 1)</xsl:attribute>
              </xsl:element>
            </invalid>
            <content>
              <xsl:element name="xsl:value-of">
                <xsl:attribute name="select">$fieldValue</xsl:attribute>
              </xsl:element>
            </content>
            <xsl:element name="xsl:copy-of">
              <xsl:attribute name="select">$vocabulary</xsl:attribute>
            </xsl:element>
          </field>
        </error>
      </xsl:element>
      <!-- generatePSubfieldError Template End -->
      
      <!-- 
      /marc:collection 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="match">/marc:collection</xsl:attribute>
        <collectionValidationReport>
          <xsl:element name="xsl:apply-templates"/>
        </collectionValidationReport>
      </xsl:element>
      <!-- /marc:collection End -->
            
      <!-- 
      marc
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="match">marc:record</xsl:attribute>
        <validationReport>
          <xsl:call-template name="ValidateLeader"/>
          <xsl:call-template name="NonRepeatableFields"/>
          <xsl:call-template name="MandatoryFields"/>
          
          <xsl:element name="xsl:apply-templates">
            <xsl:attribute name="select">marc:controlfield</xsl:attribute>
          </xsl:element>
          <xsl:element name="xsl:apply-templates">
            <xsl:attribute name="select">marc:datafield</xsl:attribute>
          </xsl:element>
        </validationReport>
      </xsl:element>
      <!-- marc End -->
      
      <!-- ControlfieldCheck -->
      <xsl:call-template name="ControlfieldCheck"/>
      
      <!-- 
      Unknown control fields 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="match">marc:controlfield</xsl:attribute>
        <xsl:attribute name="priority">-1</xsl:attribute>
        <warning>
          <xsl:attribute name="type">UnknownControlfieldTag</xsl:attribute>
          <xsl:element name="xsl:copy-of">
            <xsl:attribute name="select">.</xsl:attribute>
          </xsl:element>
        </warning>
      </xsl:element>
      <!-- Unknown control fields End -->
      
      <!-- Datafield -->
      <xsl:call-template name="DatafieldCheck"/>
      
      <!-- 
      Unknown fields 
      -->
      <xsl:element name="xsl:template">
        <xsl:attribute name="match">marc:datafield</xsl:attribute>
        <xsl:attribute name="priority">-1</xsl:attribute>
        <warning>
          <xsl:attribute name="type">UnknownTag</xsl:attribute>
          <xsl:element name="xsl:copy-of">
            <xsl:attribute name="select">.</xsl:attribute>
          </xsl:element>
        </warning>
      </xsl:element>
      <!-- Unknown fields End -->
    </axsl:stylesheet>
  </xsl:template>

  <!-- 
  ValidateLeader 
  -->
  <xsl:template name="ValidateLeader">
    <xsl:element name="xsl:variable">
      <xsl:attribute name="name">leader</xsl:attribute>

      <xsl:element name="xsl:value-of">
        <xsl:attribute name="select">//marc:record/marc:leader</xsl:attribute>
      </xsl:element>
    </xsl:element>

    <xsl:for-each select="format-description/files/file">
      <xsl:variable name="href" select="text()"/>
      
      <xsl:for-each select="document($href)/FORMAT/LEADER/node()">
        <xsl:variable name="curNode" select="name()"/>
        <xsl:variable name="start" select="@start"/>
        <xsl:variable name="length" select="@length"/>
        
        <xsl:if test="string-length($start) > 0">
          <xsl:element name="xsl:variable">
            <xsl:attribute name="name"><xsl:value-of select="$curNode"/></xsl:attribute>
            <xsl:attribute name="select">substring($leader, <xsl:value-of select="$start"/>, <xsl:value-of select="$length"/>)</xsl:attribute>
          </xsl:element>
          
          <xsl:element name="xsl:if">
            <xsl:attribute name="test">not(contains('<xsl:for-each select="OPTION"><xsl:value-of select="@value"/></xsl:for-each>', $<xsl:value-of   select="$curNode"/>))</xsl:attribute>
            <error type="Leader">
              <xsl:attribute name="domain"><xsl:value-of select="$curNode"/></xsl:attribute>
              <xsl:attribute name="start"><xsl:value-of select="$start"/></xsl:attribute>
              <xsl:attribute name="length"><xsl:value-of select="$length"/></xsl:attribute>
              <invalid>
                <xsl:element name="xsl:value-of">
                  <xsl:attribute name="select">$<xsl:value-of select="$curNode"/></xsl:attribute>
                </xsl:element>
              </invalid>
              <content>
                <xsl:element name="xsl:value-of">
                  <xsl:attribute name="select">$leader</xsl:attribute>
                </xsl:element>
              </content>
              <valid-options>
                <xsl:copy-of select="child::node()"/>
              </valid-options>
            </error>
          </xsl:element>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- ValidateLeader End-->
  
  <!-- 
  NonRepeatableFields Template 
  -->
  <xsl:template name="NonRepeatableFields">
    <xsl:for-each select="format-description/files/file">
      <xsl:variable name="href" select="text()"/>
      
      <xsl:for-each select="document($href)/FORMAT/FIELD">
        <xsl:if test="@repeatable = 'n'">
          <xsl:variable name="tag" select="@tag"/>
          <xsl:if test="starts-with($tag, '00') and not(contains($tag, '-'))">
            <xsl:element name="xsl:if">
              <xsl:attribute name="test">count(marc:controlfield[@tag = <xsl:value-of select="$tag"/>]) > 1</xsl:attribute>
              <error type="RepeatedControlfield">
                <xsl:element name="xsl:copy-of">
                  <xsl:attribute name="select">marc:controlfield[@tag = <xsl:value-of select="$tag"/>]</xsl:attribute>
                </xsl:element>
              </error>
            </xsl:element>
          </xsl:if>
          <xsl:if test="not(starts-with($tag, '00')) and not(contains($tag, '-'))">
            <xsl:element name="xsl:if">
              <xsl:attribute name="test">count(marc:datafield[@tag = <xsl:value-of select="$tag"/>]) > 1</xsl:attribute>
              <error type="RepeatedDatafield">
                <xsl:element name="xsl:copy-of">
                  <xsl:attribute name="select">marc:datafield[@tag = <xsl:value-of select="$tag"/>]</xsl:attribute>
                </xsl:element>
              </error>
            </xsl:element>
          </xsl:if>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- NonRepeatableFields Template -->
  
  <!-- 
  MandatoryFields Template 
  -->
  <xsl:template name="MandatoryFields">
    <xsl:for-each select="format-description/files/file">
      <xsl:variable name="href" select="text()"/>
      
      <xsl:for-each select="document($href)/FORMAT/FIELD">
        <xsl:if test="@mandatory = 'y'">
          <xsl:variable name="tag" select="@tag"/>
          <xsl:if test="starts-with($tag, '00') and not(contains($tag, '-'))">
            <xsl:element name="xsl:if">
              <xsl:attribute name="test">not(marc:controlfield[@tag = <xsl:value-of select="$tag"/>])</xsl:attribute>
              <error type="MandatoryControlfield">
                <xsl:attribute name="tag"><xsl:value-of select="$tag"/></xsl:attribute>
              </error>
            </xsl:element>
          </xsl:if>
          <xsl:if test="not(starts-with($tag, '00')) and not(contains($tag, '-'))">
            <xsl:element name="xsl:if">
              <xsl:attribute name="test">not(marc:datafield[@tag = <xsl:value-of select="$tag"/>])</xsl:attribute>
              <error type="MandatoryDatafield">
                <xsl:attribute name="tag"><xsl:value-of select="$tag"/></xsl:attribute>
              </error>
            </xsl:element>
          </xsl:if>
        </xsl:if>
        <!--
        Conditional Mandatory Fields
        -->
        <xsl:if test="@mandatory = 'c'">
          <xsl:variable name="tag" select="@tag"/>
          <xsl:if test="starts-with($tag, '00') and not(contains($tag, '-'))">
            <xsl:element name="xsl:if">
              <xsl:attribute name="test">not(marc:controlfield[@tag = <xsl:value-of select="$tag"/>]) and (<xsl:value-of select="MANDATORY-CONDITION/RULE"/>)</xsl:attribute>
              <error type="MandatoryControlfield">
                <xsl:attribute name="tag"><xsl:value-of select="$tag"/></xsl:attribute>
              </error>
            </xsl:element>
          </xsl:if>
          <xsl:if test="not(starts-with($tag, '00')) and not(contains($tag, '-'))">
            <xsl:element name="xsl:if">
              <xsl:attribute name="test">not(marc:datafield[@tag = <xsl:value-of select="$tag"/>]) and (<xsl:value-of select="MANDATORY-CONDITION/RULE"/>)</xsl:attribute>
              <error type="MandatoryDatafield">
                <xsl:attribute name="tag"><xsl:value-of select="$tag"/></xsl:attribute>
              </error>
            </xsl:element>
          </xsl:if>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- MandatoryFields Template End -->
  
  <!-- 
  ControlfieldCheck Template 
  -->
  <xsl:template name="ControlfieldCheck">
    <xsl:for-each select="format-description/files/file">
      <xsl:variable name="href" select="text()"/>
      
      <xsl:for-each select="document($href)/FORMAT/FIELD">
        <xsl:variable name="tag" select="@tag"/>
        <xsl:if test="starts-with($tag, '00') and not(contains($tag, '-'))">
            <xsl:element name="xsl:template">
              <xsl:attribute name="match">marc:controlfield[@tag = <xsl:value-of select="$tag"/>]</xsl:attribute>
              <xsl:call-template name="PSubfieldCheck">
                <xsl:with-param name="tag">
                  <xsl:value-of select="$tag"/>
                </xsl:with-param>
                <xsl:with-param name="href">
                  <xsl:value-of select="$href"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:element>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- ControlfieldCheck Template End -->
  
  <!-- 
  DatafieldCheck Template 
  -->
  <xsl:template name="DatafieldCheck">
    <xsl:for-each select="format-description/files/file">
      <xsl:variable name="href" select="text()"/>
      
      <xsl:for-each select="document($href)/FORMAT/FIELD">
        <xsl:variable name="tag" select="@tag"/>
        <xsl:if test="not(starts-with($tag, '00')) and not(contains($tag, '-'))">
            <xsl:element name="xsl:template">
              <xsl:attribute name="match">marc:datafield[@tag = <xsl:value-of select="$tag"/>]</xsl:attribute>
              <xsl:element name="xsl:call-template">
                <xsl:attribute name="name">validateDatafield</xsl:attribute>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">sCodesR</xsl:attribute>
                  <xsl:call-template name="GetSCodesR"/>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">sCodesNR</xsl:attribute>
                  <xsl:call-template name="GetSCodesNR"/>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">sCodesO</xsl:attribute>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">i1Values</xsl:attribute>
                  <xsl:attribute name="xml:space">preserve</xsl:attribute>
                  <xsl:call-template name="GetIndicator1Values"/>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">i2Values</xsl:attribute>
                  <xsl:attribute name="xml:space">preserve</xsl:attribute>
                  <xsl:call-template name="GetIndicator2Values"/>
                </xsl:element>
              </xsl:element>
            </xsl:element>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- DatafieldCheck Template End -->
  
  <!-- 
  GetSCodesR Template 
  -->
  <xsl:template name="GetSCodesR">
    <xsl:for-each select="SUBFIELD">
      <xsl:if test="@repeatable = 'y'">
        <xsl:value-of select="@tag"/>
      </xsl:if>
      <xsl:call-template name="GetSCodesR"/>
    </xsl:for-each>
  </xsl:template>
  <!-- GetSCodesR Template End -->
  
  <!-- 
  GetSCodesNR Template 
  -->
  <xsl:template name="GetSCodesNR">
    <xsl:for-each select="SUBFIELD">
      <xsl:if test="@repeatable = 'n'">
        <xsl:value-of select="@tag"/>
      </xsl:if>
      <xsl:call-template name="GetSCodesNR"/>
    </xsl:for-each>
  </xsl:template>
  <!-- GetSCodesNR Template End -->
  
  <!-- 
  GetIndicator1Values Template 
  -->
  <xsl:template name="GetIndicator1Values">
    <xsl:choose>
      <xsl:when test="IND1/OPTION">
        <xsl:for-each select="IND1/OPTION">
          <xsl:value-of select="@value"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise><![CDATA[<xsl:value-of select="' '"/>]]></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- GetIndicator1Values Template End -->
  
  <!-- 
  GetIndicator2Values Template 
  -->
  <xsl:template name="GetIndicator2Values">
    <xsl:choose>
      <xsl:when test="IND2/OPTION">
        <xsl:for-each select="IND2/OPTION">
          <xsl:value-of select="@value"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise><![CDATA[<xsl:value-of select="' '"/>]]></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- GetIndicator2Values Template End -->
  
  <!-- 
  PSubfieldCheck Template 
  -->
  <xsl:template name="PSubfieldCheck">
    <xsl:param name="tag"/>
    <xsl:param name="sfTag"/>
    
    <xsl:element name="xsl:variable">
      <xsl:attribute name="name">leader</xsl:attribute>
      <xsl:element name="xsl:value-of">
        <xsl:attribute name="select">//marc:record/marc:leader</xsl:attribute>
      </xsl:element>
    </xsl:element>
    <xsl:element name="xsl:variable">
      <xsl:attribute name="name">content</xsl:attribute>
      <xsl:element name="xsl:value-of">
        <xsl:attribute name="select">.</xsl:attribute>
      </xsl:element>
    </xsl:element>
    <!-- For later -->
    <xsl:if test="$sfTag != ''">
    </xsl:if>
    <xsl:if test="$tag != ''">
      <!-- PSUBFIELD's without conditions -->
      <xsl:for-each select="format-description/files/file">
        <xsl:variable name="href" select="text()"/>
        
        <xsl:for-each select="document($href)/FORMAT/FIELD[@tag = $tag]/PSUBFIELD">
          <xsl:element name="xsl:call-template">
            <xsl:attribute name="name">validatePSubfield</xsl:attribute>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name">start</xsl:attribute>
              <xsl:value-of select="@start"/>
            </xsl:element>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name">end</xsl:attribute>
              <xsl:value-of select="@end"/>
            </xsl:element>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name">vocabulary</xsl:attribute>
              <xsl:call-template name="GetPSubfieldVocabulary"/>
            </xsl:element>
          </xsl:element>
        </xsl:for-each>
      </xsl:for-each>
      
      <!-- PSUBFIELD's with conditions -->
      <xsl:for-each select="format-description/files/file">
        <xsl:variable name="href" select="text()"/>

        <xsl:for-each select="document($href)/FORMAT/FIELD[@tag = $tag]/APPLYIF">
          <xsl:variable name="condition">
            <xsl:value-of select="@condition"/>
          </xsl:variable>
          <xsl:for-each select="PSUBFIELD">
            <xsl:element name="xsl:if">
              <xsl:attribute name="test"><xsl:value-of select="$condition"/></xsl:attribute>
              <xsl:element name="xsl:call-template">
                <xsl:attribute name="name">validatePSubfield</xsl:attribute>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">start</xsl:attribute>
                  <xsl:value-of select="@start"/>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">end</xsl:attribute>
                  <xsl:value-of select="@end"/>
                </xsl:element>
                <xsl:element name="xsl:with-param">
                  <xsl:attribute name="name">vocabulary</xsl:attribute>
                  <xsl:call-template name="GetPSubfieldVocabulary"/>
                </xsl:element>
              </xsl:element>
            </xsl:element>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <!-- PSubfieldCheck Template End -->
  
  <!-- 
  GetPSubfieldVocabulary Template 
  -->
  <xsl:template name="GetPSubfieldVocabulary">
    <vocabulary>
      <xsl:for-each select="VOCABULARY/ITEM">
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </vocabulary>
  </xsl:template>
  <!-- GetPSubfieldVocabulary Template End -->
</xsl:stylesheet>