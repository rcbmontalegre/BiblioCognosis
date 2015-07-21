<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:f="http://idi.ntnu.no/frbrizer/"
	xmlns:local="http://idi.ntnu.no/frbrizer/">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
	<xsl:variable name="basic-uri" select="'basic.xslt'"/>
	<xsl:variable name="merge-uri" select="'merge.xslt'"/>
	<xsl:param name="userdefined-uri" required="no" select="''"/>
	<xsl:template match="/*:templates">
		<xsl:element name="xsl:stylesheet">
			<xsl:attribute name="version" select="'2.0'"/>
			<xsl:attribute name="exclude-result-prefixes" select="'xs local'"/>
			<xsl:namespace name="local" select="'http://idi.ntnu.no/frbrizer/'"/>
			<xsl:namespace name="f" select="'http://idi.ntnu.no/frbrizer/'"/>
			<xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'debug'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_MARC001_in_entityrecord'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_MARC001_in_controlfield'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_MARC001_in_subfield'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_MARC001_in_relationships'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_labels'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_entitylabel'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'true()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_anchorvalues'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_templateinfo'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_sourceinfo'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_keyvalues'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_internal_key'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_counters'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'UUID_identifiers'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'true()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'merge'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'true()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'ignore_indicators_in_merge'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_id_as_element'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_missing_reverse_relationships'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'true()'"/>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name" select="'include_target_entity_type'"/>
				<xsl:attribute name="as" select="'xs:boolean'"/>
				<xsl:attribute name="select" select="'false()'"/>
			</xsl:element>
			<xsl:element name="xsl:output">
				<xsl:attribute name="method" select="'xml'"/>
				<xsl:attribute name="version" select="'1.0'"/>
				<xsl:attribute name="encoding" select="'UTF-8'"/>
				<xsl:attribute name="indent" select="'yes'"/>
			</xsl:element>
			<xsl:call-template name="collection-template"/>
			<xsl:call-template name="templates-template"/>
			<xsl:call-template name="entity"/>
			<xsl:call-template name="create-key-mapping-templates"/>
			<xsl:call-template name="create-key-replacement-template"/>
			<xsl:call-template name="create-labels-template"/>
			<xsl:copy-of select="doc($basic-uri)/*/xsl:template"/>
			<xsl:copy-of select="doc($basic-uri)/*/xsl:function"/>			
			<xsl:apply-templates mode="createmergetemplate" select="doc($merge-uri)"/>
			<xsl:apply-templates mode="createnomergetemplate" select="doc($merge-uri)"/>
			<xsl:if test="$userdefined-uri ne ''">
				<xsl:copy-of select="doc($userdefined-uri)/*/xsl:template"/>
				<xsl:copy-of select="doc($userdefined-uri)/*/xsl:function"/>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="entity">
		<xsl:for-each select="entity">
			<xsl:sort select="@*:templatename"/>
			<xsl:element name="xsl:template">
				<xsl:attribute name="name" select="@*:templatename"/>
				<xsl:element name="xsl:variable">
					<xsl:attribute name="name" select="'this_template_name'"/>
					<xsl:attribute name="select" select="string-join(('''',@*:templatename,''''),'')"/>
				</xsl:element>
				<xsl:element name="xsl:variable">
					<xsl:attribute name="name" select="'tag'"/>
					<xsl:attribute name="as" select="'xs:string'"/>
					<xsl:attribute name="select" select="string-join(('''', *:anchor/@*:tag, ''''), '')"/>
				</xsl:element>		
				<xsl:if test="exists(anchor/@code)">
					<xsl:element name="xsl:variable">
						<xsl:attribute name="name" select="'code'"/>
						<xsl:attribute name="select" select="anchor/@code"/>
					</xsl:element>
				</xsl:if>
				<xsl:element name="xsl:variable">
					<xsl:attribute name="name" select="'record'"/>
					<xsl:attribute name="select" select="'.'"/>
				</xsl:element>
				<xsl:element name="xsl:variable">
					<xsl:attribute name="name" select="'marcid'"/>
					<xsl:attribute name="select" select="'*:controlfield[@*:tag=''001'']'"/>
				</xsl:element>
				<xsl:call-template name="tag-for-each"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="tag-for-each">
		<xsl:element name="xsl:for-each">
			<xsl:attribute name="select"
				select="string-join(('node()[@*:tag=''',anchor/@tag,''']', if (anchor/@condition) then concat('[', anchor/@condition, ']') else ()), '')"/>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'this_field'"/>
				<xsl:attribute name="select"
					select="'(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)'"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'anchor_field'"/>
				<xsl:attribute name="select"
					select="'(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)'"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'this_field_position'"/>
				<xsl:attribute name="as" select="'xs:string'"/>
				<xsl:attribute name="select" select="'string(position())'"/>
			</xsl:element>
			<xsl:choose>
				<xsl:when test="exists(anchor/code)">
					<xsl:call-template name="code-for-each"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="record-template"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>

	<xsl:template name="code-for-each">
		<xsl:element name="xsl:for-each">
			<xsl:attribute name="select"
				select="string-join(('node()[@*:code=''',anchor/code/@code,''']', if (anchor/code/@condition) then string-join(('[', anchor/code/@condition, ']'), '') else ()), '')"/>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'this_subfield'"/>
				<xsl:attribute name="select" select="'(ancestor-or-self::*:subfield)'"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'anchor_subfield'"/>
				<xsl:attribute name="select" select="'(ancestor-or-self::*:subfield)'"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'this_subfield_code'"/>
				<xsl:attribute name="select" select="anchor/code/@code"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'anchor_subfield_code'"/>
				<xsl:attribute name="select" select="anchor/code/@code"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'this_subfield_position'"/>
				<xsl:attribute name="as" select="'xs:string'"/>
				<xsl:attribute name="select" select="'string(position())'"/>
			</xsl:element>
			<xsl:call-template name="record-template"/>
		</xsl:element>
	</xsl:template>

	<xsl:template name="record-template">
		<xsl:element name="xsl:element">
			<xsl:attribute name="name" select="'{name(ancestor-or-self::*:record)}'"/>
			<xsl:attribute name="namespace" select="'{namespace-uri(ancestor-or-self::*:record)}'"/>
			<!-- getting name of record-element from source file to preserve the namespace -->
			<xsl:variable name="record-identifier-string">
				<xsl:call-template name="internal-id-template">
					<xsl:with-param name="code"
						select="if (anchor/code) then '$this_subfield_code'  else ()"/>
					<xsl:with-param name="code-pos"
						select="if (anchor/code) then '$this_subfield_position'  else ()"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:element name="xsl:attribute">
				<xsl:attribute name="name" select="'f:id'"/>
				<xsl:attribute name="select" select="$record-identifier-string"/>
			</xsl:element>
			<xsl:if test="exists(@*:type) and @*:type ne ''">
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:type'"/>
					<xsl:attribute name="select" select="local:xpathify(@*:type)"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="exists(@*:subtype) and @subtype ne ''">
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:subtype'"/>
					<xsl:attribute name="select" select="local:xpathify(@*:subtype)"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="exists(@label) and @label ne ''">
				<xsl:element name="xsl:if">
					<xsl:attribute name="test" select="'$include_labels'"/>
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:label'"/>
						<xsl:attribute name="select" select="local:xpathify(@*:label)"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<xsl:element name="xsl:attribute">
				<xsl:attribute name="name" select="'f:templatename'"/>
				<xsl:attribute name="select" select="'$this_template_name'"/>
			</xsl:element>
			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_counters'"/>
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:c'"/>
					<xsl:attribute name="select" select="'1'"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_anchorvalues'"/>
				<xsl:element name="xsl:element">
					<xsl:attribute name="name" select="'f:anchorvalue'"/>
					<xsl:element name="xsl:if">
						<xsl:attribute name="test" select="'$include_counters'"/>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name" select="'f:c'"/>
							<xsl:attribute name="select" select="'1'"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="xsl:value-of">
						<xsl:attribute name="select" select="'.'"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_templateinfo'"/>
				<xsl:element name="xsl:element">
					<xsl:attribute name="name" select="'f:templatename'"/>
					<xsl:element name="xsl:if">
						<xsl:attribute name="test" select="'$include_counters'"/>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name" select="'f:c'"/>
							<xsl:attribute name="select" select="'1'"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="xsl:value-of">
						<xsl:attribute name="select" select="'$this_template_name'"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_internal_key'"/>
				<xsl:element name="xsl:element">
					<xsl:attribute name="name" select="'f:intkey'"/>
					<xsl:element name="xsl:if">
						<xsl:attribute name="test" select="'$include_counters'"/>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name" select="'f:c'"/>
							<xsl:attribute name="select" select="'1'"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="xsl:value-of">
						<xsl:attribute name="select" select="$record-identifier-string"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>

			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_MARC001_in_entityrecord'"/>
				<xsl:element name="xsl:element">
					<xsl:attribute name="name" select="'f:mid'"/>
					<xsl:element name="xsl:if">
						<xsl:attribute name="test" select="'$include_counters'"/>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name" select="'f:c'"/>
							<xsl:attribute name="select" select="'1'"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:i'"/>
						<xsl:attribute name="select" select="'$marcid'"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:call-template name="controlfields"/>
			<xsl:call-template name="datafields"/>
			<xsl:call-template name="relationships"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="datafields">
		<xsl:if test="count(attributes/datafield) > 0 ">
			<xsl:variable name="anchortag" select="anchor/@tag"/>
			<xsl:for-each select="attributes/datafield">
				<xsl:choose>
					<xsl:when test="@tag = $anchortag">
						<xsl:variable name="p1" select="'$record/*:datafield[@*:tag='''"/>
						<xsl:variable name="p2" select="@tag"/>
						<xsl:variable name="p3" select="''']'"/>
						<xsl:variable name="p5"
							select="if (exists(@condition)) then (string-join(('[',@condition,']'),'')) else ('[. = $this_field]')"/>
						<xsl:variable name="p6"
							select="concat('[*:subfield/@*:code = (''' ,string-join((for $c in distinct-values(*:subfield/@*:code) return $c), ''','''), ''')]')"/>
						<xsl:call-template name="datafield">
							<xsl:with-param name="p" select="string-join(($p1,$p2,$p3,$p5,$p6),'')"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="subtype" select="@subtype"/>
							<xsl:with-param name="label" select="@label"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="p1" select="'$record/*:datafield[@*:tag='''"/>
						<xsl:variable name="p2" select="@tag"/>
						<xsl:variable name="p3" select="''']'"/>
						<xsl:variable name="p5"
							select="if (exists(@condition)) then (string-join(('[',@condition,']'),'')) else ('')"/>
						<xsl:variable name="p6"
							select="concat('[*:subfield/@*:code = (''' ,string-join((for $c in distinct-values(*:subfield/@code) return $c), ''','''), ''')]')"/>
						<xsl:call-template name="datafield">
							<xsl:with-param name="p" select="string-join(($p1,$p2,$p3,$p5,$p6),'')"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="subtype" select="@subtype"/>
							<xsl:with-param name="label" select="@label"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="datafield">
		<xsl:param name="p" required="yes"/>
		<xsl:param name="type" required="no" select="''"/>
		<xsl:param name="subtype" required="no" select="''"/>
		<xsl:param name="label" required="no" select="''"/>
		<xsl:element name="xsl:for-each">
			<xsl:attribute name="select" select="$p"/>
			<xsl:element name="xsl:copy">
				<xsl:element name="xsl:call-template">
					<xsl:attribute name="name" select="'copy-attributes'"/>
				</xsl:element>
				<xsl:if test="string($type) ne ''">
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:type'"/>
						<xsl:attribute name="select" select="local:xpathify($type)"/>							
					</xsl:element>
				</xsl:if>
				<xsl:if test="string($subtype) ne ''">
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:subtype'"/>
						<xsl:attribute name="select" select="local:xpathify($subtype)"/>							
					</xsl:element>
				</xsl:if>
				<xsl:if test="string($label) ne ''">
					<xsl:element name="xsl:if">
						<xsl:attribute name="test" select="'$include_labels'"/>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name" select="'f:label'"/>
							<xsl:attribute name="select" select="local:xpathify($label)"/>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:element name="xsl:if">
					<xsl:attribute name="test" select="'$include_counters'"/>
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:c'"/>
						<xsl:attribute name="select" select="'1'"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="xsl:for-each">
					<xsl:variable name="p">
						<xsl:element name="part">
							<xsl:value-of select="'*:subfield[@*:code = (''' "/>
						</xsl:element>
						<xsl:element name="part">
							<xsl:value-of
								select="string-join((for $c in distinct-values(*:subfield/@*:code) return $c), ''',''')"
							/>
						</xsl:element>
						<xsl:element name="part">
							<xsl:value-of select="''')]'"/>
						</xsl:element>
					</xsl:variable>
					<xsl:attribute name="select" select="string-join($p/part, '')"/>
					<xsl:for-each select="*:subfield">
						<xsl:element name="xsl:if">
							<xsl:attribute name="test"
								select="string-join(('@*:code = ''',@*:code,'''', if (exists(@*:condition)) then concat(' and ', @*:condition) else ()),'')"/>
							<xsl:choose>
								<xsl:when test="exists(@*:type)">
									<xsl:element name="xsl:copy">
										<xsl:element name="xsl:call-template">
											<xsl:attribute name="name" select="'copy-content'"/>
											<xsl:if test="exists(@*:type) and @*:type ne ''">
												<xsl:element name="xsl:with-param">
													<xsl:attribute name="name" select="'type'"/>
													<xsl:attribute name="select" select="local:xpathify(@*:type)"/>
												</xsl:element>
											</xsl:if>
											<xsl:if test="exists(@*:subtype) and @*:subtype ne ''">
												<xsl:element name="xsl:with-param">
													<xsl:attribute name="name" select="'subtype'"/>
													<xsl:attribute name="select" select="local:xpathify(@*:subtype)"/>
												</xsl:element>
											</xsl:if>
											<xsl:if test="exists(@*:type) and @*:label ne ''">
												<xsl:element name="xsl:with-param">
													<xsl:attribute name="name" select="'label'"/>
													<xsl:attribute name="select" select="local:xpathify(@*:label)"/>
												</xsl:element>
											</xsl:if>
											<xsl:element name="xsl:with-param">
												<xsl:attribute name="name" select="'select'"/>
												<xsl:attribute name="select"
												select="if (exists(@select) and (string-length(@select)) != 0) then @select else ('.')"
												/>
											</xsl:element>
										</xsl:element>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="xsl:copy-of">
										<xsl:attribute name="select" select="'.'"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
				<xsl:element name="xsl:if">
					<xsl:attribute name="test" select="'$include_MARC001_in_subfield'"/>
					<xsl:element name="xsl:element">
						<xsl:attribute name="name" select="'f:mid'"/>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name" select="'f:i'"/>
							<xsl:attribute name="select" select="'$marcid'"/>
						</xsl:element>
						<xsl:element name="xsl:if">
							<xsl:attribute name="test" select="'$include_counters'"/>
							<xsl:element name="xsl:attribute">
								<xsl:attribute name="name" select="'f:c'"/>
								<xsl:attribute name="select" select="'1'"/>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
<!--	<xsl:template name="subfields">
		<xsl:for-each select="*:subfield">
			<xsl:element name="xsl:when">
				<xsl:attribute name="test"
					select="string-join( ('../@*:tag = ''', ../@*:tag, ''' and @*:code = ''', @*:code, ''' ', if (exists(@*:condition)) then string-join(('and ', @*:condition, ' '),'') else ()),'')"/>
				<xsl:choose>
					<xsl:when test="exists(@*:type)">
						<xsl:element name="xsl:copy">
							<xsl:element name="xsl:call-template">
								<xsl:attribute name="name" select="'copy-contenttttttt'"/>		
								<xsl:if test="string(@*:type) ne ''">
									<xsl:element name="xsl:with-param">
										<xsl:attribute name="name" select="'type'"/>
										<xsl:attribute name="select" select="local:xpathify(@*:type)"/>							
									</xsl:element>
								</xsl:if>
								<xsl:if test="string(@*:subtype) ne ''">
									<xsl:element name="xsl:with-param">
										<xsl:attribute name="name" select="'subtype'"/>
										<xsl:attribute name="select" select="local:xpathify(@*:subtype)"/>							
									</xsl:element>
								</xsl:if>
								<xsl:if test="string(@*:label) ne ''">
									<xsl:element name="xsl:with-param">
										<xsl:attribute name="name" select="'label'"/>
										<xsl:attribute name="select" select="local:xpathify(@*:label)"/>
									</xsl:element>
								</xsl:if>								
							</xsl:element>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:element name="xsl:copy-of">
							<xsl:attribute name="select" select="'.'"/>
						</xsl:element>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>-->
	
	<xsl:template name="controlfields">
		<xsl:if test="count(attributes/controlfield) > 0 ">
			<xsl:variable name="tag" select="anchor/@tag"/>
			<xsl:for-each select="attributes/controlfield">
				<xsl:choose>
					<xsl:when test="@tag = $tag">
						<xsl:variable name="p1" select="'$record/*:controlfield[@*:tag='''"/>
						<xsl:variable name="p2" select="@tag"/>
						<xsl:variable name="p3" select="''']'"/>
						<xsl:variable name="p4" select="'[$this_field_position]'"/>
						<xsl:variable name="p5"
							select="if (exists(condition)) then (string-join(('[',condition,']'),'')) else ('')"/>
						<xsl:call-template name="controlfield">
							<xsl:with-param name="p" select="string-join(($p1,$p2,$p3,$p4,$p5),'')"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="subtype" select="@subtype"/>
							<xsl:with-param name="label" select="@label"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="p1" select="'$record/*:controlfield[@*:tag='''"/>
						<xsl:variable name="p2" select="@*:tag"/>
						<xsl:variable name="p3" select="''']'"/>
						<xsl:call-template name="controlfield">
							<xsl:with-param name="p" select="string-join(($p1,$p2,$p3),'')"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="subtype" select="@subtype"/>
							<xsl:with-param name="label" select="@label"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="controlfield">
		<xsl:param name="p" required="yes"/>
		<xsl:param name="type" required="no" select="''"/>
		<xsl:param name="label" required="no" select="''"/>
		<xsl:param name="subtype" required="no" select="''"/>
		<xsl:element name="xsl:for-each">
			<xsl:attribute name="select" select="$p"/>
			<xsl:element name="xsl:copy">
				<xsl:element name="xsl:call-template">
					<xsl:attribute name="name" select="'copy-content'"/>
					<xsl:if test="string($type) ne ''">
						<xsl:element name="xsl:with-param">
							<xsl:attribute name="name" select="'type'"/>
							<xsl:attribute name="select" select="local:xpathify($type)"/>								
						</xsl:element>
					</xsl:if>
					<xsl:if test="string($subtype) ne ''">
						<xsl:element name="xsl:with-param">
							<xsl:attribute name="name" select="'subtype'"/>
							<xsl:attribute name="select" select="local:xpathify($subtype)"/>							
						</xsl:element>
					</xsl:if>
					<xsl:if test="string($label) ne ''">
						<xsl:element name="xsl:with-param">
							<xsl:attribute name="name" select="'label'"/>
							<xsl:attribute name="select" select="local:xpathify($label)"/>
						</xsl:element>
					</xsl:if>
					<!--<xsl:if test="string($type) ne ''">
						<xsl:element name="xsl:with-param">
							<xsl:attribute name="name" select="'type'"/>
							<xsl:attribute name="select" select="concat('''', $type, '''')"/>							
						</xsl:element>
						<xsl:element name="xsl:with-param">
							<xsl:attribute name="name" select="'label'"/>
							<xsl:attribute name="select" select="concat('''', $label, '''')"/>
						</xsl:element>
					</xsl:if>-->
					<xsl:element name="xsl:with-param">
						<xsl:attribute name="name" select="'select'"/>
						<xsl:attribute name="select" select="'.'"/>
					</xsl:element>
					<xsl:element name="xsl:with-param">
						<xsl:attribute name="name" select="'marcid'"/>
						<xsl:attribute name="select" select="'$marcid'"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template name="relationships">
		<xsl:for-each select="*:relationships/*:relationship/*:target[@*:entity = //*:templates/*:entity/@*:templatename]">
			<!-- condition in the xpath-selection is used to avoid linking to non-existing templates -->
			<xsl:choose>
				<xsl:when test="exists(parent::*:relationship/@condition)">
					<xsl:element name="xsl:if">
						<xsl:attribute name="test" select="string(parent::*:relationship/@condition)"/>
						<xsl:call-template name="relationship-target-tag-for-each"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="relationship-target-tag-for-each"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="relationship-target-tag-for-each">
		<xsl:element name="xsl:for-each">
			<xsl:variable name="target_template_name" select="string(@entity)"/>
			<xsl:variable name="target_template"
				select="//*:templates/*:entity[@*:templatename = $target_template_name]"/>
			<xsl:attribute name="select"
				select="string-join(('$record/node()[@*:tag=''',string($target_template/anchor/@tag),''']', if ($target_template/anchor/@condition) then concat('[', $target_template/anchor/@condition, ']') else () ), '')"/>

			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'target_template_name'"/>
				<xsl:attribute name="select"
					select="string-join(('''',$target_template_name,''''),'')"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'target_tag'"/>
				<xsl:attribute name="select"
					select="string-join(('''',$target_template/anchor/@tag,''''),'')"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'target_field'"/>
				<xsl:attribute name="select"
					select="'(ancestor-or-self::*:datafield, ancestor-or-self::*:controlfield)'"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'target_field_position'"/>
				<xsl:attribute name="as" select="'xs:string'"/>
				<xsl:attribute name="select" select="'string(position())'"/>
			</xsl:element>
			<xsl:choose>
				<xsl:when test="exists($target_template/anchor/code)">
					<xsl:call-template name="relationship-target-code-for-each">
						<xsl:with-param name="target_template" select="$target_template"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="relationship-with-or-without-if">
						<xsl:with-param name="target_template" select="$target_template"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>


	<xsl:template name="relationship-target-code-for-each">
		<xsl:param name="target_template"/>
		<xsl:element name="xsl:for-each">
			<xsl:attribute name="select"
				select="string-join(('node()[@*:code=''',string($target_template/anchor/code/@code),''']', if ($target_template/anchor/code/@condition) then concat('[', $target_template/anchor/code/@condition, ']') else ()), '')"/>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'target_subfield'"/>
				<xsl:attribute name="select" select="'.'"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'target_subfield_code'"/>
				<xsl:attribute name="select" select="$target_template/anchor/code/@code"/>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'target_subfield_position'"/>
				<xsl:attribute name="as" select="'xs:string'"/>
				<xsl:attribute name="select" select="'string(position())'"/>
			</xsl:element>
			<xsl:call-template name="relationship-with-or-without-if">
				<xsl:with-param name="target_template" select="$target_template"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>

	<xsl:template name="relationship-with-or-without-if">
		<xsl:param name="target_template"/>
		<xsl:choose>
			<xsl:when test="exists(@condition) or (@same-field eq 'true')">
				<xsl:call-template name="relationship-if">
					<xsl:with-param name="target_template" select="$target_template"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="relationship">
					<xsl:with-param name="target_template" select="$target_template"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="relationship-if">
		<xsl:param name="target_template"/>
		<xsl:element name="xsl:if">
			<xsl:variable name="target_condition"
				select="if (@condition) then string-join(('(', @condition, ')'), '') else ()"/>
			<xsl:variable name="same_target_tag_condition"
				select="if ((@same-field = 'true' and ($target_template/anchor/@tag eq ancestor::entity/anchor/@tag))) then '($target_field = $this_field)' else ()"/>
			<xsl:attribute name="test"
				select="string-join(($target_condition, $same_target_tag_condition), ' and ')"/>
			<xsl:call-template name="relationship">
				<xsl:with-param name="target_template" select="$target_template"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>


	<xsl:template name="relationship">
		<xsl:param name="target_template"/>
		<xsl:element name="f:relationship">
		
			<xsl:variable name="target_typeid" select="$target_template/@*:type"/>
		
			<xsl:if test="exists(../@type)">
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:type'"/>
					<xsl:attribute name="select" select="local:xpathify(../@*:type)"/>
				</xsl:element>
			</xsl:if>
			
			<xsl:if test="exists(../@label)">
				<xsl:element name="xsl:if">
					<xsl:attribute name="test" select="'$include_labels'"/>
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:label'"/>
						<xsl:attribute name="select" select="local:xpathify(../@*:label)"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>

			<xsl:if test="exists(../@*:subtype)">
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:subtype'"/>
					<xsl:attribute name="select" select="local:xpathify(../@*:subtype)"/>
				</xsl:element>
			</xsl:if>
			
			<xsl:if test="exists(../@*:itype)">
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:itype'"/>
					<xsl:attribute name="select" select="local:xpathify(../@*:itype)"/>
				</xsl:element>
			</xsl:if>
			
			<xsl:if test="exists(../@*:ilabel)">
				<xsl:element name="xsl:if">
					<xsl:attribute name="test" select="'$include_labels'"/>
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:ilabel'"/>
						<xsl:attribute name="select" select="local:xpathify(../@*:ilabel)"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			
			<!--<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_labels'"/>
				<xsl:if test="exists(../@*:label)">
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:label'"/>
						<xsl:attribute name="select" select="concat('''',../@*:label,'''')"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="exists(../@*:ilabel)">
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:ilabel'"/>
						<xsl:attribute name="select" select="concat('''',../@*:ilabel,'''')"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>-->
	
			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_target_entity_type'"/>
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:target_type'"/>
					<xsl:attribute name="select" select="concat('''',$target_typeid,'''')"/>
				</xsl:element>
			</xsl:element>
			
			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_counters'"/>
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:c'"/>
					<xsl:attribute name="select" select="'1'"/>
				</xsl:element>
			</xsl:element>


			<xsl:variable name="identifier_string">
				<xsl:call-template name="internal-id-template">
					<xsl:with-param name="template_name" select="'$target_template_name'"/>
					<xsl:with-param name="tag" select="'$target_tag'"/>
					<xsl:with-param name="code"
						select="if ($target_template/anchor/code) then '$target_subfield_code'  else ()"/>
					<xsl:with-param name="tag-pos" select="'$target_field_position'"/>
					<xsl:with-param name="code-pos"
						select="if ($target_template/anchor/code) then '$target_subfield_position'  else ()"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:element name="xsl:attribute">
				<xsl:attribute name="name" select="'f:href'"/>
				<xsl:attribute name="select" select="$identifier_string"/>
			</xsl:element>
			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_internal_key'"/>
				<xsl:element name="xsl:attribute">
					<xsl:attribute name="name" select="'f:intkey'"/>
					<xsl:attribute name="select" select="$identifier_string"/>
				</xsl:element>
			</xsl:element>

			<xsl:element name="xsl:if">
				<xsl:attribute name="test" select="'$include_MARC001_in_relationships'"/>
				<xsl:element name="xsl:element">
					<xsl:attribute name="name" select="'f:mid'"/>
					<xsl:element name="xsl:attribute">
						<xsl:attribute name="name" select="'f:i'"/>
						<xsl:attribute name="select" select="'$marcid'"/>
					</xsl:element>
					<xsl:element name="xsl:if">
						<xsl:attribute name="test" select="'$include_counters'"/>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name" select="'f:c'"/>
							<xsl:attribute name="select" select="'1'"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>

		</xsl:element>
	</xsl:template>

	<!-- template for creating internal identifier value -->
	<xsl:template name="internal-id-template">
		<xsl:param name="id" required="no" select="'$record/@*:id'"/>
		<xsl:param name="template_name" required="no" select="'$this_template_name'"/>
		<xsl:param name="tag" required="no" select="'$tag'"/>
		<xsl:param name="code"/>
		<xsl:param name="tag-pos" required="no" select="'$this_field_position'"/>
		<xsl:param name="code-pos"/>
		<xsl:variable name="elements"
			select="string-join(($id, $template_name, $tag, $code, $tag-pos, $code-pos), ',') "/>
		<xsl:value-of select="concat('string-join((', $elements, '), '':'')')"/>
	</xsl:template>

	<xsl:template name="collection-template">
		<xsl:element name="xsl:template">
			<xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
			<xsl:attribute name="match" select="'/*:collection'"/>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'collection'"/>
				<xsl:element name="xsl:copy">
					<xsl:element name="xsl:namespace">
						<xsl:attribute name="name" select="'f'"/>
						<xsl:attribute name="select" select="concat('''','http://idi.ntnu.no/frbrizer/','''')"/>						
					</xsl:element>
					<xsl:element name="xsl:call-template">
						<xsl:attribute name="name" select="'copy-attributes'"/>
					</xsl:element>
					<xsl:element name="xsl:for-each">
						<xsl:attribute name="select" select="'*:record'"/>
						<xsl:element name="xsl:call-template">
							<xsl:attribute name="name" select="'record-set'"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:choose">
				<xsl:element name="xsl:when">
					<xsl:attribute name="test" select="'$merge'"/>
					<xsl:element name="xsl:apply-templates">
						<xsl:attribute name="select" select="'$collection'"/>
						<xsl:attribute name="mode" select="'merge'"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="xsl:otherwise">
					<xsl:element name="xsl:apply-templates">
						<xsl:attribute name="select" select="'$collection'"/>
						<xsl:attribute name="mode" select="'nomerge'"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template name="templates-template">
		<xsl:element name="xsl:template">
			<xsl:attribute name="match" select="'*:record'"/>
			<xsl:attribute name="name" select="'record-set'"/>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'step1'"/>
				<xsl:element name="f:record-set">
					<xsl:for-each select="*:entity">
						<xsl:element name="xsl:call-template">
							<xsl:attribute name="name" select="@*:templatename"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'step2'"/>
				<xsl:element name="xsl:apply-templates">
					<xsl:attribute name="select" select="'$step1'"/>
					<xsl:attribute name="mode" select="'create-inverse-relationships'"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'step3'"/>
				<xsl:element name="xsl:apply-templates">
					<xsl:attribute name="select" select="'$step2'"/>
					<xsl:attribute name="mode" select="'create-keys'"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'step4'"/>
				<xsl:element name="xsl:apply-templates">
					<xsl:attribute name="select" select="'$step3'"/>
					<xsl:attribute name="mode" select="'create-labels'"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'step5'"/>
				<xsl:element name="xsl:apply-templates">
					<xsl:attribute name="select" select="'$step4'"/>
					<xsl:attribute name="mode" select="'remove-record-set'"/>
				</xsl:element>
			</xsl:element>			
			<xsl:element name="xsl:copy-of">
				<xsl:attribute name="select" select="'$step5'"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template name="create-key-mapping-templates">
		<xsl:variable name="keyfilter" select="keyfilter"/>
		<xsl:variable name="rules" select="."/>
		<xsl:variable name="ordernumbers"
			select="for $i in xs:integer(min(entity/key/@order)) to xs:integer(max(entity/key/@order)) return $i"
			xmlns:xs="http://www.w3.org/2001/XMLSchema"/>
		<xsl:for-each select="$ordernumbers">
			<xsl:variable name="order" select="."/>
			<xsl:element name="xsl:template">
				<xsl:attribute name="match" select="'f:record-set'"/>
				<xsl:attribute name="mode" select="concat('create-key-mapping-step-', $order) "/>
				<xsl:element name="f:keymap">
					<xsl:element name="xsl:for-each">
						<xsl:attribute name="select" select="'*:record'"/>
						<xsl:element name="xsl:choose">
							<xsl:for-each select="$rules/*:entity[*:key/@*:order = $order]">
								<xsl:element name="xsl:when">
									<xsl:attribute name="test"
										select="concat('@*:templatename = ''', @*:templatename,'''')"/>
									<xsl:element name="xsl:element">
										<xsl:attribute name="name" select="'f:keyentry'"/>
										<xsl:element name="xsl:variable">
											<xsl:attribute name="name" select="'key'"/>
											<xsl:for-each select="*:key/*:element">
												<xsl:element name="xsl:value-of">
												<xsl:attribute name="select"
												select="string-join(('local:sort-keys(',.,')'), '')"/>
												</xsl:element>
											</xsl:for-each>
											<xsl:element name="xsl:value-of">
												<xsl:attribute name="select" select="'concat(''\'',@*:type, ''#'')'"/>
											</xsl:element>
										</xsl:element>

										<xsl:element name="xsl:variable">
											<xsl:attribute name="name" select="'keyvalue'"/>
											<xsl:attribute name="select" select="$keyfilter"/>
										</xsl:element>

										<xsl:element name="xsl:attribute">
											<xsl:attribute name="name" select="'f:key'"/>
											<xsl:attribute name="select" select="'$keyvalue'"/>
										</xsl:element>

										<xsl:element name="xsl:attribute">
											<xsl:attribute name="name" select="'f:id'"/>
											<xsl:attribute name="select" select="'@*:id'"/>
										</xsl:element>

									</xsl:element>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="create-key-replacement-template">
		<xsl:variable name="ordernumbers"
			select="for $i in xs:integer(min(*:entity/*:key/@*:order)) to xs:integer(max(*:entity/*:key/@order)) return $i"
			xmlns:xs="http://www.w3.org/2001/XMLSchema"/>

		<xsl:element name="xsl:template">
			<xsl:attribute name="match" select="'*:record-set'"/>
			<xsl:attribute name="mode" select="'create-keys'"/>

			<xsl:element name="xsl:variable">
				<xsl:attribute name="name" select="'set-phase-0'"/>
				<xsl:attribute name="select" select="'.'"/>
			</xsl:element>

			<xsl:for-each select="$ordernumbers">
				<xsl:variable name="order" select="."/>

				<xsl:element name="xsl:variable">
					<xsl:attribute name="name"
						select="string-join(('keys-phase-', string($order)), '') "/>
					<xsl:element name="xsl:apply-templates">
						<xsl:attribute name="select"
							select="  string-join(('$set-phase-', string($order - 1)), '')        "/>
						<xsl:attribute name="mode"
							select="  string-join(('create-key-mapping-step-', string($order)), '')        "
						/>
					</xsl:element>
				</xsl:element>


				<xsl:element name="xsl:variable">
					<xsl:attribute name="name"
						select=" string-join(('set-phase-', string($order)), '') "/>
					<xsl:element name="xsl:apply-templates">
						<xsl:attribute name="select"
							select="string-join(('$set-phase-', string($order - 1)), '')"/>
						<xsl:attribute name="mode" select="'replace-keys'"/>
						<xsl:element name="xsl:with-param">
							<xsl:attribute name="name" select="'keymapping'"/>
							<xsl:attribute name="select"
								select="   string-join(('$keys-phase-', string($order )), '')  "/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
			<xsl:element name="xsl:copy-of">
				<xsl:attribute name="select"
					select=" string-join(('$set-phase-', string(max($ordernumbers ))), '') "/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template name="createmergetemplate" mode="createmergetemplate"
		match="/xsl:stylesheet/xsl:template[@match='/*:collection']/xsl:copy">
		<xsl:element name="xsl:template">
			<xsl:attribute name="match" select="'/*:collection'"/>
			<xsl:attribute name="mode" select="'merge'"/>
			<xsl:attribute name="name" select="'merge'"/>
			<xsl:copy-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template name="createnomergetemplate" mode="createnomergetemplate"
		match="/xsl:stylesheet/xsl:template[@match='/*:collection']/xsl:copy">
		<xsl:element name="xsl:template">
			<xsl:attribute name="match" select="'/*:collection'"/>
			<xsl:attribute name="mode" select="'nomerge'"/>
			<xsl:attribute name="name" select="'nomerge'"/>
			<xsl:element name="xsl:copy">
				<xsl:element name="xsl:copy-of">
					<xsl:attribute name="select" select="'//*:record'"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template name="create-labels-template">
		<xsl:element name="xsl:template">
			<xsl:attribute name="match" select="'*:record-set'"/>
			<xsl:attribute name="mode" select="'create-labels'"/>
			<xsl:element name="xsl:copy">
				<xsl:element name="xsl:for-each">
					<xsl:attribute name="select" select="'*:record'"/>
					<xsl:element name="xsl:variable">
						<xsl:attribute name="name" select="'record'"/>
						<xsl:attribute name="select" select="'.'"/>
					</xsl:element>
					<xsl:element name="xsl:copy">
						<xsl:element name="xsl:copy-of">
							<xsl:attribute name="select" select="'@*|node()'"/>
						</xsl:element>
						<xsl:element name="xsl:choose">
							<xsl:for-each select="entity">
								<xsl:element name="xsl:when">
									<xsl:attribute name="test" select="concat('@*:templatename = ', '''', @*:templatename, '''')"/>
									<xsl:element name="xsl:element">
										<xsl:attribute name="name" select="'f:label'"/>
										<xsl:element name="xsl:if">
											<xsl:attribute name="test" select="'$include_counters'"/>
											<xsl:element name="xsl:attribute">
												<xsl:attribute name="name" select="'f:c'"/>
												<xsl:attribute name="select" select="'1'"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="xsl:value-of">
											<xsl:attribute name="select" select="label/@select"/>
										</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:element>
				</xsl:element>			
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:function name="local:xpathify">
		<xsl:param name="astring" as="xs:string"/>
		<xsl:choose>
			<xsl:when test="starts-with($astring, '{') and ends-with($astring, '}')">
				<xsl:value-of select="replace($astring, '[\{\}]', '')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('''', $astring, '''')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

</xsl:stylesheet>
