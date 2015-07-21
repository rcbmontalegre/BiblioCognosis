<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:local="http://idi.ntnu.no/frbrizer/" xmlns:f="http://idi.ntnu.no/frbrizer/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"
                exclude-result-prefixes="xs local">
   <xsl:param name="debug" as="xs:boolean" select="false()"/>
   <xsl:param name="include_MARC001_in_entityrecord" as="xs:boolean" select="false()"/>
   <xsl:param name="include_MARC001_in_controlfield" as="xs:boolean" select="false()"/>
   <xsl:param name="include_MARC001_in_subfield" as="xs:boolean" select="false()"/>
   <xsl:param name="include_MARC001_in_relationships" as="xs:boolean" select="false()"/>
   <xsl:param name="include_labels" as="xs:boolean" select="false()"/>
   <xsl:param name="include_entitylabel" as="xs:boolean" select="true()"/>
   <xsl:param name="include_anchorvalues" as="xs:boolean" select="false()"/>
   <xsl:param name="include_templateinfo" as="xs:boolean" select="false()"/>
   <xsl:param name="include_sourceinfo" as="xs:boolean" select="false()"/>
   <xsl:param name="include_keyvalues" as="xs:boolean" select="false()"/>
   <xsl:param name="include_internal_key" as="xs:boolean" select="false()"/>
   <xsl:param name="include_counters" as="xs:boolean" select="false()"/>
   <xsl:param name="UUID_identifiers" as="xs:boolean" select="true()"/>
   <xsl:param name="merge" as="xs:boolean" select="true()"/>
   <xsl:param name="ignore_indicators_in_merge" as="xs:boolean" select="false()"/>
   <xsl:param name="include_id_as_element" as="xs:boolean" select="false()"/>
   <xsl:param name="include_missing_reverse_relationships" as="xs:boolean" select="true()"/>
   <xsl:param name="include_target_entity_type" as="xs:boolean" select="false()"/>
   <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
   <xsl:template match="/*:collection">
      <xsl:variable name="collection">
         <xsl:copy>
            <xsl:namespace name="f" select="'http://idi.ntnu.no/frbrizer/'"/>
            <xsl:call-template name="copy-attributes"/>
            <xsl:for-each select="*:record">
               <xsl:call-template name="record-set"/>
            </xsl:for-each>
         </xsl:copy>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$merge">
            <xsl:apply-templates select="$collection" mode="merge"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates select="$collection" mode="nomerge"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*:record" name="record-set">
      <xsl:variable name="step1">
         <f:record-set>
            <xsl:call-template name="MARC21-700-Person"/>
            <xsl:call-template name="MARC21-200-Work"/>
         </f:record-set>
      </xsl:variable>
      <xsl:variable name="step2">
         <xsl:apply-templates select="$step1" mode="create-inverse-relationships"/>
      </xsl:variable>
      <xsl:variable name="step3">
         <xsl:apply-templates select="$step2" mode="create-keys"/>
      </xsl:variable>
      <xsl:variable name="step4">
         <xsl:apply-templates select="$step3" mode="create-labels"/>
      </xsl:variable>
      <xsl:variable name="step5">
         <xsl:apply-templates select="$step4" mode="remove-record-set"/>
      </xsl:variable>
      <xsl:copy-of select="$step5"/>
   </xsl:template>
   <xsl:template name="MARC21-200-Work">
      <xsl:variable name="this_template_name" select="'MARC21-200-Work'"/>
      <xsl:variable name="tag" as="xs:string" select="'200'"/>
      <xsl:variable name="record" select="."/>
      <xsl:variable name="marcid" select="*:controlfield[@*:tag='001']"/>
      <xsl:for-each select="node()[@*:tag='200']">
         <xsl:variable name="this_field"
                       select="(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)"/>
         <xsl:variable name="anchor_field"
                       select="(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)"/>
         <xsl:variable name="this_field_position" as="xs:string" select="string(position())"/>
         <xsl:element name="{name(ancestor-or-self::*:record)}"
                      namespace="{namespace-uri(ancestor-or-self::*:record)}">
            <xsl:attribute name="f:id"
                           select="string-join(($record/@*:id,$this_template_name,$tag,$this_field_position), ':')"/>
            <xsl:attribute name="f:type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/C1001'"/>
            <xsl:if test="$include_labels">
               <xsl:attribute name="f:label" select="'Work'"/>
            </xsl:if>
            <xsl:attribute name="f:templatename" select="$this_template_name"/>
            <xsl:if test="$include_counters">
               <xsl:attribute name="f:c" select="1"/>
            </xsl:if>
            <xsl:if test="$include_anchorvalues">
               <xsl:element name="f:anchorvalue">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:value-of select="."/>
               </xsl:element>
            </xsl:if>
            <xsl:if test="$include_templateinfo">
               <xsl:element name="f:templatename">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:value-of select="$this_template_name"/>
               </xsl:element>
            </xsl:if>
            <xsl:if test="$include_internal_key">
               <xsl:element name="f:intkey">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:value-of select="string-join(($record/@*:id,$this_template_name,$tag,$this_field_position), ':')"/>
               </xsl:element>
            </xsl:if>
            <xsl:if test="$include_MARC001_in_entityrecord">
               <xsl:element name="f:mid">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:attribute name="f:i" select="$marcid"/>
               </xsl:element>
            </xsl:if>
            <xsl:for-each select="$record/*:datafield[@*:tag='200'][. = $this_field][*:subfield/@*:code = ('a')]">
               <xsl:copy>
                  <xsl:call-template name="copy-attributes"/>
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:for-each select="*:subfield[@*:code = ('a')]">
                     <xsl:if test="@*:code = 'a'">
                        <xsl:copy>
                           <xsl:call-template name="copy-content">
                              <xsl:with-param name="type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P3001'"/>
                              <xsl:with-param name="label" select="'has title of the work'"/>
                              <xsl:with-param name="select" select="."/>
                           </xsl:call-template>
                        </xsl:copy>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="$include_MARC001_in_subfield">
                     <xsl:element name="f:mid">
                        <xsl:attribute name="f:i" select="$marcid"/>
                        <xsl:if test="$include_counters">
                           <xsl:attribute name="f:c" select="1"/>
                        </xsl:if>
                     </xsl:element>
                  </xsl:if>
               </xsl:copy>
            </xsl:for-each>
            <xsl:for-each select="$record/*:datafield[@*:tag='304'][*:subfield/@*:code = ('a')]">
               <xsl:copy>
                  <xsl:call-template name="copy-attributes"/>
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:for-each select="*:subfield[@*:code = ('a')]">
                     <xsl:if test="@*:code = 'a'">
                        <xsl:copy>
                           <xsl:call-template name="copy-content">
                              <xsl:with-param name="type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P3001'"/>
                              <xsl:with-param name="label" select="'has title of the work'"/>
                              <xsl:with-param name="select" select="."/>
                           </xsl:call-template>
                        </xsl:copy>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="$include_MARC001_in_subfield">
                     <xsl:element name="f:mid">
                        <xsl:attribute name="f:i" select="$marcid"/>
                        <xsl:if test="$include_counters">
                           <xsl:attribute name="f:c" select="1"/>
                        </xsl:if>
                     </xsl:element>
                  </xsl:if>
               </xsl:copy>
            </xsl:for-each>
            <xsl:for-each select="$record/*:datafield[@*:tag='210'][*:subfield/@*:code = ('d')]">
               <xsl:copy>
                  <xsl:call-template name="copy-attributes"/>
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:for-each select="*:subfield[@*:code = ('d')]">
                     <xsl:if test="@*:code = 'd'">
                        <xsl:copy>
                           <xsl:call-template name="copy-content">
                              <xsl:with-param name="type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P3003'"/>
                              <xsl:with-param name="label" select="'has date of work'"/>
                              <xsl:with-param name="select" select="."/>
                           </xsl:call-template>
                        </xsl:copy>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="$include_MARC001_in_subfield">
                     <xsl:element name="f:mid">
                        <xsl:attribute name="f:i" select="$marcid"/>
                        <xsl:if test="$include_counters">
                           <xsl:attribute name="f:c" select="1"/>
                        </xsl:if>
                     </xsl:element>
                  </xsl:if>
               </xsl:copy>
            </xsl:for-each>
         </xsl:element>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="MARC21-700-Person">
      <xsl:variable name="this_template_name" select="'MARC21-700-Person'"/>
      <xsl:variable name="tag" as="xs:string" select="'700'"/>
      <xsl:variable name="record" select="."/>
      <xsl:variable name="marcid" select="*:controlfield[@*:tag='001']"/>
      <xsl:for-each select="node()[@*:tag='700']">
         <xsl:variable name="this_field"
                       select="(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)"/>
         <xsl:variable name="anchor_field"
                       select="(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)"/>
         <xsl:variable name="this_field_position" as="xs:string" select="string(position())"/>
         <xsl:element name="{name(ancestor-or-self::*:record)}"
                      namespace="{namespace-uri(ancestor-or-self::*:record)}">
            <xsl:attribute name="f:id"
                           select="string-join(($record/@*:id,$this_template_name,$tag,$this_field_position), ':')"/>
            <xsl:attribute name="f:type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/C1005'"/>
            <xsl:if test="$include_labels">
               <xsl:attribute name="f:label" select="'Person'"/>
            </xsl:if>
            <xsl:attribute name="f:templatename" select="$this_template_name"/>
            <xsl:if test="$include_counters">
               <xsl:attribute name="f:c" select="1"/>
            </xsl:if>
            <xsl:if test="$include_anchorvalues">
               <xsl:element name="f:anchorvalue">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:value-of select="."/>
               </xsl:element>
            </xsl:if>
            <xsl:if test="$include_templateinfo">
               <xsl:element name="f:templatename">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:value-of select="$this_template_name"/>
               </xsl:element>
            </xsl:if>
            <xsl:if test="$include_internal_key">
               <xsl:element name="f:intkey">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:value-of select="string-join(($record/@*:id,$this_template_name,$tag,$this_field_position), ':')"/>
               </xsl:element>
            </xsl:if>
            <xsl:if test="$include_MARC001_in_entityrecord">
               <xsl:element name="f:mid">
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:attribute name="f:i" select="$marcid"/>
               </xsl:element>
            </xsl:if>
            <xsl:for-each select="$record/*:datafield[@*:tag='700'][. = $this_field][*:subfield/@*:code = ('b','a','f')]">
               <xsl:copy>
                  <xsl:call-template name="copy-attributes"/>
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:for-each select="*:subfield[@*:code = ('b','a','f')]">
                     <xsl:if test="@*:code = 'b'">
                        <xsl:copy>
                           <xsl:call-template name="copy-content">
                              <xsl:with-param name="type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P3039'"/>
                              <xsl:with-param name="label" select="'has name of person'"/>
                              <xsl:with-param name="select" select="."/>
                           </xsl:call-template>
                        </xsl:copy>
                     </xsl:if>
                     <xsl:if test="@*:code = 'a'">
                        <xsl:copy>
                           <xsl:call-template name="copy-content">
                              <xsl:with-param name="type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P3039'"/>
                              <xsl:with-param name="label" select="'has name of person'"/>
                              <xsl:with-param name="select" select="."/>
                           </xsl:call-template>
                        </xsl:copy>
                     </xsl:if>
                     <xsl:if test="@*:code = 'f'">
                        <xsl:copy>
                           <xsl:call-template name="copy-content">
                              <xsl:with-param name="type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P3040'"/>
                              <xsl:with-param name="label" select="'has dates of person'"/>
                              <xsl:with-param name="select" select="."/>
                           </xsl:call-template>
                        </xsl:copy>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="$include_MARC001_in_subfield">
                     <xsl:element name="f:mid">
                        <xsl:attribute name="f:i" select="$marcid"/>
                        <xsl:if test="$include_counters">
                           <xsl:attribute name="f:c" select="1"/>
                        </xsl:if>
                     </xsl:element>
                  </xsl:if>
               </xsl:copy>
            </xsl:for-each>
            <xsl:for-each select="$record/node()[@*:tag='200']">
               <xsl:variable name="target_template_name" select="'MARC21-200-Work'"/>
               <xsl:variable name="target_tag" select="'200'"/>
               <xsl:variable name="target_field"
                             select="(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)"/>
               <xsl:variable name="target_field_position" as="xs:string" select="string(position())"/>
               <f:relationship>
                  <xsl:attribute name="f:type" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P2010'"/>
                  <xsl:attribute name="f:itype" select="'http://iflastandards.info/ns/fr/frbr/frbrer/P2009'"/>
                  <xsl:if test="$include_target_entity_type">
                     <xsl:attribute name="f:target_type"
                                    select="'http://iflastandards.info/ns/fr/frbr/frbrer/C1001'"/>
                  </xsl:if>
                  <xsl:if test="$include_counters">
                     <xsl:attribute name="f:c" select="1"/>
                  </xsl:if>
                  <xsl:attribute name="f:href"
                                 select="string-join(($record/@*:id,$target_template_name,$target_tag,$target_field_position), ':')"/>
                  <xsl:if test="$include_internal_key">
                     <xsl:attribute name="f:intkey"
                                    select="string-join(($record/@*:id,$target_template_name,$target_tag,$target_field_position), ':')"/>
                  </xsl:if>
                  <xsl:if test="$include_MARC001_in_relationships">
                     <xsl:element name="f:mid">
                        <xsl:attribute name="f:i" select="$marcid"/>
                        <xsl:if test="$include_counters">
                           <xsl:attribute name="f:c" select="1"/>
                        </xsl:if>
                     </xsl:element>
                  </xsl:if>
               </f:relationship>
            </xsl:for-each>
         </xsl:element>
      </xsl:for-each>
   </xsl:template>
   <xsl:template match="f:record-set" mode="create-key-mapping-step-1">
      <f:keymap>
         <xsl:for-each select="*:record">
            <xsl:choose>
               <xsl:when test="@*:templatename = 'MARC21-700-Person'">
                  <xsl:element name="f:keyentry">
                     <xsl:variable name="key">
                        <xsl:value-of select="local:sort-keys(*:datafield[@tag = '700'][1]/*:subfield[@code = 'b'][1])"/>
                        <xsl:value-of select="local:sort-keys(*:datafield[@tag = '700'][1]/*:subfield[@code = 'a'][1])"/>
                        <xsl:value-of select="local:sort-keys(*:datafield[@tag = '700'][1]/*:subfield[@code = 'f'][1])"/>
                        <xsl:value-of select="concat('\',@*:type, '#')"/>
                     </xsl:variable>
                     <xsl:variable name="keyvalue"
                                   select="replace(lower-case(string-join($key, '\')), '[^a-z0-9\\#|¤§]', '')"/>
                     <xsl:attribute name="f:key" select="$keyvalue"/>
                     <xsl:attribute name="f:id" select="@*:id"/>
                  </xsl:element>
               </xsl:when>
            </xsl:choose>
         </xsl:for-each>
      </f:keymap>
   </xsl:template>
   <xsl:template match="f:record-set" mode="create-key-mapping-step-2">
      <f:keymap>
         <xsl:for-each select="*:record">
            <xsl:choose>
               <xsl:when test="@*:templatename = 'MARC21-200-Work'">
                  <xsl:element name="f:keyentry">
                     <xsl:variable name="key">
                        <xsl:value-of select="local:sort-keys(local:sort-relationships(*:relationship[ends-with(@*:type, 'P2009')])[1]/@*:href)"/>
                        <xsl:value-of select="local:sort-keys(*:datafield[@tag = '200']/*:subfield[@code = 'a'][1])"/>
                        <xsl:value-of select="local:sort-keys(*:datafield[@tag = '210']/*:subfield[@code = 'd'][1])"/>
                        <xsl:value-of select="concat('\',@*:type, '#')"/>
                     </xsl:variable>
                     <xsl:variable name="keyvalue"
                                   select="replace(lower-case(string-join($key, '\')), '[^a-z0-9\\#|¤§]', '')"/>
                     <xsl:attribute name="f:key" select="$keyvalue"/>
                     <xsl:attribute name="f:id" select="@*:id"/>
                  </xsl:element>
               </xsl:when>
            </xsl:choose>
         </xsl:for-each>
      </f:keymap>
   </xsl:template>
   <xsl:template match="*:record-set" mode="create-keys">
      <xsl:variable name="set-phase-0" select="."/>
      <xsl:variable name="keys-phase-1">
         <xsl:apply-templates select="$set-phase-0" mode="create-key-mapping-step-1"/>
      </xsl:variable>
      <xsl:variable name="set-phase-1">
         <xsl:apply-templates select="$set-phase-0" mode="replace-keys">
            <xsl:with-param name="keymapping" select="$keys-phase-1"/>
         </xsl:apply-templates>
      </xsl:variable>
      <xsl:variable name="keys-phase-2">
         <xsl:apply-templates select="$set-phase-1" mode="create-key-mapping-step-2"/>
      </xsl:variable>
      <xsl:variable name="set-phase-2">
         <xsl:apply-templates select="$set-phase-1" mode="replace-keys">
            <xsl:with-param name="keymapping" select="$keys-phase-2"/>
         </xsl:apply-templates>
      </xsl:variable>
      <xsl:copy-of select="$set-phase-2"/>
   </xsl:template>
   <xsl:template match="*:record-set" mode="create-labels">
      <xsl:copy>
         <xsl:for-each select="*:record">
            <xsl:variable name="record" select="."/>
            <xsl:copy>
               <xsl:copy-of select="@*|node()"/>
               <xsl:choose>
                  <xsl:when test="@*:templatename = 'MARC21-700-Person'">
                     <xsl:element name="f:label">
                        <xsl:if test="$include_counters">
                           <xsl:attribute name="f:c" select="1"/>
                        </xsl:if>
                        <xsl:value-of select="string-join( (*:datafield[@tag='700']/*:subfield[@code = 'b'], *:datafield[@tag='700']/*:subfield[@code = 'a']), ' ' )"/>
                     </xsl:element>
                  </xsl:when>
                  <xsl:when test="@*:templatename = 'MARC21-200-Work'">
                     <xsl:element name="f:label">
                        <xsl:if test="$include_counters">
                           <xsl:attribute name="f:c" select="1"/>
                        </xsl:if>
                        <xsl:value-of select="*:datafield[@tag='240']/*:subfield[@code = 'a']"/>
                     </xsl:element>
                  </xsl:when>
               </xsl:choose>
            </xsl:copy>
         </xsl:for-each>
      </xsl:copy>
   </xsl:template>
   <xsl:template name="copy-content">
		    <xsl:param name="type" required="no" select="''"/>
		    <xsl:param name="subtype" required="no" select="''"/>
		    <xsl:param name="label" required="no" select="''"/>
		    <xsl:param name="select" required="no"/>
		    <xsl:param name="marcid" required="no"/>
		    <xsl:call-template name="copy-attributes"/>
		    <xsl:if test="$type ne ''">
			      <xsl:attribute name="f:type" select="$type"/>
		    </xsl:if>
		    <xsl:if test="$subtype ne ''">
			      <xsl:attribute name="f:subtype" select="$subtype"/>
		    </xsl:if>
		    <xsl:if test="$include_labels and ($label ne '')">
			      <xsl:if test="$label ne ''">
				        <xsl:attribute name="f:label" select="$label"/>
			      </xsl:if>
		    </xsl:if>
		    <xsl:value-of select="$select"/>
		    <xsl:if test="$include_MARC001_in_controlfield ">
			      <xsl:if test="string($marcid) ne ''">
				        <xsl:element name="f:mid">
					          <xsl:attribute name="f:i" select="$marcid"/>
				        </xsl:element>
			      </xsl:if>
		    </xsl:if>
	  </xsl:template>
   <xsl:template name="copy-attributes">
		    <xsl:for-each select="@*">
			      <xsl:copy/>
		    </xsl:for-each>
	  </xsl:template>
   <xsl:template match="*:record-set" mode="replace-keys" name="replace-keys">
		    <xsl:param name="keymapping" required="yes"/>
		    <xsl:copy>
			      <xsl:call-template name="copy-attributes"/>
			      <xsl:for-each select="*:record">
				        <xsl:variable name="record_id" select="@*:id"/>
				        <xsl:choose>
					          <xsl:when test="$keymapping//*:keyentry[@*:id = $record_id]">
						            <xsl:copy>
							              <xsl:for-each select="@*">
								                <xsl:choose>
									                  <xsl:when test="local-name() = 'id'">
										                    <xsl:attribute name="f:id" select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"/>
									                  </xsl:when>
									                  <xsl:otherwise>
										                    <xsl:copy-of select="."/>
									                  </xsl:otherwise>
								                </xsl:choose>
							              </xsl:for-each>
							              <xsl:if test="$include_sourceinfo">
								                <xsl:element name="f:source">
									                  <xsl:attribute name="f:c" select="1"/>
									                  <xsl:value-of select="$record_id"/>
								                </xsl:element>
							              </xsl:if>
							              <xsl:if test="$include_keyvalues">
								                <xsl:element name="f:keyvalue">
									                  <xsl:if test="$include_counters">
										                    <xsl:attribute name="f.c" select="1"/>
									                  </xsl:if>
									                  <xsl:value-of select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"/>
								                </xsl:element>
							              </xsl:if>
							              <xsl:if test="$include_id_as_element">
								                <xsl:element name="f:idvalue">
									                  <xsl:attribute name="f:c" select="'1'"/>
									                  <xsl:attribute name="f:id" select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"/>
									                  <xsl:value-of select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"/>
								                </xsl:element>
							              </xsl:if>
							              <xsl:for-each select="node()">
								                <xsl:choose>
									                  <xsl:when test="@*:href = $keymapping//*:keyentry/@*:id">
										                    <xsl:variable name="temp" select="@*:href"/>
										                    <xsl:copy>
											                      <xsl:for-each select="@*">
												                        <xsl:choose>
												                           <xsl:when test="local-name() = 'href'">
												                              <xsl:attribute name="f:href" select="$keymapping//*:keyentry[@*:id = $temp]/@*:key"/>
												                           </xsl:when>
												                           <xsl:otherwise>
												                              <xsl:copy-of select="."/>
												                           </xsl:otherwise>
												                        </xsl:choose>
											                      </xsl:for-each>
											                      <xsl:for-each select="node()">
												                        <xsl:copy-of select="."/>
											                      </xsl:for-each>
										                    </xsl:copy>
									                  </xsl:when>
									                  <xsl:otherwise>
										                    <xsl:copy-of select="."/>
									                  </xsl:otherwise>
								                </xsl:choose>

							              </xsl:for-each>
						            </xsl:copy>
					          </xsl:when>
					          <xsl:when test="exists(*:relationship[@*:href = $keymapping//*:keyentry/@*:id])">
						            <xsl:copy>
							              <xsl:call-template name="copy-attributes"/>
							              <xsl:for-each select="node()">
								                <xsl:choose>
									                  <xsl:when test="local-name() = 'relationship'">
										                    <xsl:variable name="href" select="@*:href"/>
										                    <xsl:copy>
											                      <xsl:for-each select="@*">
												                        <xsl:choose>
												                           <xsl:when test="local-name() = 'href' and exists($keymapping//*:keyentry[@*:id = $href]/@*:key)">
												                              <xsl:attribute name="f:href" select="$keymapping//*:keyentry[@*:id = $href]/@*:key[1]"/>
												                           </xsl:when>
												                           <xsl:otherwise>
												                              <xsl:copy-of select="."/>
												                           </xsl:otherwise>
												                        </xsl:choose>
											                      </xsl:for-each>
											                      <xsl:copy-of select="f:mid"/>
										                    </xsl:copy>
									                  </xsl:when>
									                  <xsl:otherwise>
										                    <xsl:copy-of select="."/>
									                  </xsl:otherwise>
								                </xsl:choose>
							              </xsl:for-each>
						            </xsl:copy>
					          </xsl:when>
					          <xsl:otherwise>
						            <xsl:copy-of select="."/>
					          </xsl:otherwise>
				        </xsl:choose>
			      </xsl:for-each>
		    </xsl:copy>
	  </xsl:template>
   <xsl:template match="*:record-set" mode="remove-record-set">
		    <xsl:choose>
			      <xsl:when test="$UUID_identifiers">
				        <xsl:call-template name="UUID"/>
			      </xsl:when>
			      <xsl:otherwise>
				        <xsl:copy-of select="node()"/>
			      </xsl:otherwise>
		    </xsl:choose>
	  </xsl:template>
   <xsl:template match="@*|node()" mode="UUID" name="UUID">
		    <xsl:copy>
			      <xsl:copy-of select="@* except @*:id|@*:href"/>
			      <xsl:if test="exists(@*:id)">
				        <xsl:attribute xmlns:uuid="java:java.util.UUID" name="f:id"
                           select="uuid:to-string(uuid:nameUUIDFromBytes(string-to-codepoints(@*:id)))"/>
			      </xsl:if>
			      <xsl:if test="exists(@*:href)">
				        <xsl:attribute xmlns:uuid="java:java.util.UUID" name="f:href"
                           select="uuid:to-string(uuid:nameUUIDFromBytes(string-to-codepoints(@*:href)))"/>
			      </xsl:if>
			      <xsl:apply-templates mode="UUID" select="node()"/>
		    </xsl:copy>
	  </xsl:template>
   <xsl:template match="*:record-set" mode="create-inverse-relationships">
		    <xsl:if test="$include_missing_reverse_relationships">
			      <xsl:variable name="record-set" select="."/>
			      <xsl:copy>
				        <xsl:for-each select="*:record">
					          <xsl:variable name="record" select="."/>
					          <xsl:variable name="this-entity-id" select="@*:id"/>
					          <xsl:copy>
						            <xsl:copy-of select="@*|node()"/>
						            <xsl:for-each select="$record-set/*:record[*:relationship[(@*:href = $this-entity-id)]]">
							              <xsl:variable name="target-entity-type" select="@*:type"/>
							              <xsl:variable name="target-entity-label" select="@*:label"/>
							              <xsl:variable name="target-entity-id" select="@*:id"/>
							              <xsl:for-each select="*:relationship[(@*:href eq $this-entity-id) and exists(@*:itype)]">
								                <xsl:variable name="rel-type" select="@*:type"/>
								                <xsl:variable name="rel-itype" select="@*:itype"/>
								                <xsl:if test="not(exists($record/*:relationship[@*:href eq $target-entity-id and @*:itype = $rel-type and @*:type = $rel-itype]))">
									                  <xsl:copy>
										                    <xsl:attribute name="f:type" select="@*:itype"/>
										                    <xsl:if test="exists(@*:subtype)">
											                      <xsl:attribute name="f:subtype" select="@*:subtype"/>
										                    </xsl:if>
										                    <xsl:attribute name="f:itype" select="@*:type"/>
										                    <xsl:if test="$include_target_entity_type">
											                      <xsl:attribute name="f:target_type" select="$target-entity-type"/>
										                    </xsl:if>
										                    <xsl:if test="$include_counters">
											                      <xsl:attribute name="f:c" select="'1'"/>
										                    </xsl:if>
										                    <xsl:attribute name="f:href" select="$target-entity-id"/>
										                    <xsl:if test="$include_labels">
											                      <xsl:if test="@*:ilabel ne ''">
												                        <xsl:attribute name="f:label" select="@*:ilabel"/>
											                      </xsl:if>
											                      <xsl:if test="@*:label ne ''">
												                        <xsl:attribute name="f:ilabel" select="@*:label"/>
											                      </xsl:if>
										                    </xsl:if>
										                    <xsl:copy-of select="node()"/>
									                  </xsl:copy>
								                </xsl:if>
							              </xsl:for-each>
						            </xsl:for-each>
					          </xsl:copy>
				        </xsl:for-each>
			      </xsl:copy>
		    </xsl:if>
	  </xsl:template>
   <xsl:function name="local:sort-keys">
		    <xsl:param name="keys"/>
		    <xsl:perform-sort select="$keys">
			      <xsl:sort select="."/>
		    </xsl:perform-sort>
	  </xsl:function>
   <xsl:function name="local:sort-relationships">
		    <xsl:param name="relationships"/>
		    <xsl:perform-sort select="$relationships">
			      <xsl:sort select="@*:id"/>
		    </xsl:perform-sort>
	  </xsl:function>
	
	
	
		<xsl:template match="/*:collection" mode="merge" name="merge">
      <xsl:copy>
			      <xsl:for-each-group select="//*:record" group-by="@*:id">
				        <xsl:sort select="@*:type"/>
				        <xsl:sort select="@*:subtype"/>
				        <xsl:sort select="@*:id"/>
				        <xsl:element name="{name(current-group()[1])}"
                         namespace="{namespace-uri(current-group()[1])}">
					          <xsl:attribute name="f:id" select="current-group()[1]/@*:id"/>
					          <xsl:attribute name="f:type" select="current-group()[1]/@*:type"/>
					          <xsl:if test="exists(current-group()/@*:subtype)">
						            <xsl:attribute name="f:subtype">
							              <xsl:variable name="temp">
								                <xsl:perform-sort select="distinct-values(current-group()/@*:subtype[. ne ''])">
									                  <xsl:sort select="."/>
								                </xsl:perform-sort>
							              </xsl:variable>
							              <xsl:value-of select="string-join($temp, '/')"/>
						            </xsl:attribute> 
					          </xsl:if>
					          <xsl:if test="current-group()[1]/@*:label">
						            <xsl:attribute name="f:label" select="current-group()[1]/@*:label"/>
					          </xsl:if>
					          <xsl:if test="current-group()[1]/@*:c">
						            <xsl:attribute name="f:c" select="sum(current-group()/@*:c)"/>
					          </xsl:if>
					          <xsl:for-each-group select="current-group()/*:controlfield"
                                   group-by="string-join((@*:tag, @*:type, string(.)), '')">
						            <xsl:sort select="@*:tag"/>
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:copy-of select="@* except @*:c"/>
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>							
							              <xsl:value-of select="current-group()[1]"/>
							              <xsl:for-each-group select="current-group()/*:mid" group-by="@*:i">
								                <xsl:for-each select="distinct-values(current-group()/@*:i)">
									                  <f:mid>
										                    <xsl:attribute name="f:i" select="."/>
									                  </f:mid>
								                </xsl:for-each>
							              </xsl:for-each-group>							
						            </xsl:element>
					          </xsl:for-each-group>
					          <xsl:for-each-group select="current-group()/*:datafield"
                                   group-by="normalize-space(string-join(((@*:tag), @*:type, (if ($ignore_indicators_in_merge) then () else (@*:ind1, @*:ind2)), *:subfield/@*:code, *:subfield/@*:type, *:subfield/text()), ''))">
						            <xsl:sort select="@*:tag"/>
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">							
							              <xsl:copy-of select="current-group()[1]/@*:tag"/>
							              <xsl:copy-of select="current-group()[1]/@*:ind1"/>
							              <xsl:copy-of select="current-group()[1]/@*:ind2"/>
							              <xsl:copy-of select="current-group()[1]/@*:type"/>
							              <xsl:copy-of select="current-group()[1]/@*:subtype"/>
							              <xsl:copy-of select="current-group()[1]/@*:label"/>						
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="f:c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>							
							              <xsl:for-each-group select="current-group()/*:subfield" group-by="concat(@*:code,@*:type, text())">
								                <xsl:sort select="@*:code"/>
								                <xsl:sort select="@*:type"/>
								                <xsl:for-each select="distinct-values(current-group()/text())">
									                  <xsl:element name="{name(current-group()[1])}"
                                        namespace="{namespace-uri(current-group()[1])}">
										                    <xsl:copy-of select="current-group()[1]/@*:code"/>
										                    <xsl:copy-of select="current-group()[1]/@*:type"/>
										                    <xsl:copy-of select="current-group()[1]/@*:subtype"/>
										                    <xsl:if test="current-group()[1]/@*:label">
											                      <xsl:copy-of select="current-group()[1]/@*:label"/>
										                    </xsl:if>
										                    <xsl:value-of select="normalize-space(.)"/>
									                  </xsl:element>
								                </xsl:for-each>
							              </xsl:for-each-group>							
							              <xsl:for-each-group select="current-group()/*:mid" group-by="@*:i">
								                <xsl:for-each select="distinct-values(current-group()/@*:i)">
									                  <xsl:element name="{name(current-group()[1])}"
                                        namespace="{namespace-uri(current-group()[1])}">
										                    <xsl:attribute name="i" select="."/>
									                  </xsl:element>
								                </xsl:for-each>
							              </xsl:for-each-group>						
						            </xsl:element>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/*:relationship"
                                   group-by="concat(@*:type,@*:href,@*:subtype)">
						            <xsl:sort select="@*:type"/>
						            <xsl:sort select="@*:subtype"/>
						            <xsl:sort select="@*:id"/>
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:copy-of select="@* except (@*:c|@*:ilabel|@*:itype)"/>
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:for-each-group select="current-group()/*:mid" group-by="@*:i">
								                <xsl:for-each select="distinct-values(current-group()/@*:i)">
									                  <xsl:element name="{name(current-group()[1])}"
                                        namespace="{namespace-uri(current-group()[1])}">
										                    <xsl:attribute name="i" select="."/>
									                  </xsl:element>
								                </xsl:for-each>
							              </xsl:for-each-group>
						            </xsl:element>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/*:template" group-by=".">
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:value-of select="current-group()[1]"/>
						            </xsl:element>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/mid" group-by="@*:i">
						            <xsl:for-each select="distinct-values(current-group()/@*:i)">
							              <xsl:element name="{name(current-group()[1])}"
                                  namespace="{namespace-uri(current-group()[1])}">
								                <xsl:attribute name="i" select="."/>
							              </xsl:element>
						            </xsl:for-each>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/*:anchorvalue" group-by=".">
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:value-of select="current-group()[1]"/>
						            </xsl:element>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/*:idvalue" group-by="@*:id">
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:if test="current-group()[1]/@*:id">
								                <xsl:copy-of select="current-group()/@*:id"/>
							              </xsl:if>
							              <xsl:value-of select="current-group()[1]"/>
						            </xsl:element>
					          </xsl:for-each-group>
					          <xsl:for-each-group select="current-group()/*:source" group-by=".">
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:value-of select="current-group()[1]"/>
						            </xsl:element>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/*:keyvalue" group-by=".">
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:value-of select="current-group()[1]"/>
						            </xsl:element>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/*:label" group-by=".">
						            <xsl:element name="{name(current-group()[1])}"
                               namespace="{namespace-uri(current-group()[1])}">
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:value-of select="normalize-space(current-group()[1])"/>
						            </xsl:element>
					          </xsl:for-each-group>					
					          <xsl:for-each-group select="current-group()/*:intkey" group-by=".">
						            <xsl:element name="intkey">
							              <xsl:if test="current-group()[1]/@*:c">
								                <xsl:attribute name="c" select="sum(current-group()/@*:c)"/>
							              </xsl:if>
							              <xsl:value-of select="current-group()[1]"/>
						            </xsl:element>
					          </xsl:for-each-group>					
				        </xsl:element>
			      </xsl:for-each-group>
		    </xsl:copy>
   </xsl:template>
	

	
	
	
		<xsl:template match="/*:collection" mode="nomerge" name="nomerge">
      <xsl:copy>
         <xsl:copy-of select="//*:record"/>
      </xsl:copy>
   </xsl:template>
	
</xsl:stylesheet>