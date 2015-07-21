<?xml version="1.0" encoding="UTF-8"?>
<!-- Templates from this file are copied into the conversion file by make.xsl -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:f="http://idi.ntnu.no/frbrizer/">
	<xsl:param name="debug" as="xs:boolean" select="false()"/>
	<xsl:param name="include_MARC001_in_entityrecord" as="xs:boolean" select="false()"/>
	<xsl:param name="include_MARC001_in_controlfield" as="xs:boolean" select="false()"/>
	<xsl:param name="include_MARC001_in_subfield" as="xs:boolean" select="false()"/>
	<xsl:param name="include_labels" as="xs:boolean" select="false()"/>
	<xsl:param name="include_anchorvalues" as="xs:boolean" select="false()"/>
	<xsl:param name="include_templateinfo" as="xs:boolean" select="false()"/>
	<xsl:param name="include_sourceinfo" as="xs:boolean" select="false()"/>
	<xsl:param name="include_keyvalues" as="xs:boolean" select="false()"/>
	<xsl:param name="include_internal_key" as="xs:boolean" select="false()"/>
	<xsl:param name="include_counters" as="xs:boolean" select="false()"/>
	<xsl:param name="UUID_identifiers" as="xs:boolean" select="true()"/>
	<xsl:param name="merge" as="xs:boolean" select="true()"/>
	<xsl:param name="include_id_as_element" as="xs:boolean" select="false()"/>
	<xsl:param name="include_missing_reverse_relationships" as="xs:boolean" select="true()"/>
	<xsl:param name="include_target_entity_type" as="xs:boolean" select="false()"/>
	<xsl:param name="include_entity_labels" as="xs:boolean" select="true()"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<!--Template for copying subfield content. This template is used by the entity-templates-->
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

	<!--Template for copying the attributes of an element -->
	<xsl:template name="copy-attributes">
		<xsl:for-each select="@*">
			<xsl:copy/>
		</xsl:for-each>
	</xsl:template>

	<!-- Template for replacing internal keys with descriptive keys -->
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
										<xsl:attribute name="f:id"
											select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"
										/>
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
									<xsl:value-of
										select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"
									/>
								</xsl:element>
							</xsl:if>
							<xsl:if test="$include_id_as_element">
								<xsl:element name="f:idvalue">
									<xsl:attribute name="f:c" select="'1'"/>
									<xsl:attribute name="f:id"
										select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"/>
									<xsl:value-of
										select="$keymapping//*:keyentry[@*:id = $record_id]/@*:key"
									/>
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
												<xsl:attribute name="f:href"
												select="$keymapping//*:keyentry[@*:id = $temp]/@*:key"
												/>
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
												<xsl:when
												test="local-name() = 'href' and exists($keymapping//*:keyentry[@*:id = $href]/@*:key)">
												<xsl:attribute name="f:href"
												select="$keymapping//*:keyentry[@*:id = $href]/@*:key[1]"
												/>
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
				<xsl:attribute name="f:id" xmlns:uuid="java:java.util.UUID" select="uuid:to-string(uuid:nameUUIDFromBytes(string-to-codepoints(@*:id)))"/>
			</xsl:if>
			<xsl:if test="exists(@*:href)">
				<xsl:attribute name="f:href" xmlns:uuid="java:java.util.UUID" select="uuid:to-string(uuid:nameUUIDFromBytes(string-to-codepoints(@*:href)))"/>
			</xsl:if>
			<xsl:apply-templates mode="UUID" select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:function name="local:sort-keys" xmlns:local="http://idi.ntnu.no/frbrizer/">
		<xsl:param name="keys"/>
		<xsl:perform-sort select="$keys">
			<xsl:sort select="."/>
		</xsl:perform-sort>
	</xsl:function>

	<xsl:function name="local:sort-relationships" xmlns:local="http://idi.ntnu.no/frbrizer/">
		<xsl:param name="relationships"/>
		<xsl:perform-sort select="$relationships">
			<xsl:sort select="@*:id"/>
		</xsl:perform-sort>
	</xsl:function>

	<!--template for adding inverse relationships -->
	<!--uses a record-set as input and outputs a new record-set-->
	<xsl:template match="*:record-set" mode="create-inverse-relationships">
		<xsl:if test="$include_missing_reverse_relationships">
			<xsl:variable name="record-set" select="."/>
			<xsl:copy>
				<xsl:for-each select="*:record">
					<xsl:variable name="record" select="."/>
					<xsl:variable name="this-entity-id" select="@*:id"/>
					<xsl:copy>
						<xsl:copy-of select="@*|node()"/>
						<xsl:for-each
							select="$record-set/*:record[*:relationship[(@*:href = $this-entity-id)]]">
							<xsl:variable name="target-entity-type" select="@*:type"/>
							<xsl:variable name="target-entity-label" select="@*:label"/>
							<xsl:variable name="target-entity-id" select="@*:id"/>
							<xsl:for-each
								select="*:relationship[(@*:href eq $this-entity-id) and exists(@*:itype)]">
								<xsl:variable name="rel-type" select="@*:type"/>
								<xsl:variable name="rel-itype" select="@*:itype"/>
								<xsl:if
									test="not(exists($record/*:relationship[@*:href eq $target-entity-id and @*:itype = $rel-type and @*:type = $rel-itype]))">
									<xsl:copy>
										<xsl:attribute name="f:type" select="@*:itype"/>
										<xsl:if test="exists(@*:subtype)">
											<xsl:attribute name="f:subtype" select="@*:subtype"/>
										</xsl:if>
										<xsl:attribute name="f:itype" select="@*:type"/>
										<xsl:if test="$include_target_entity_type">
											<xsl:attribute name="f:target_type"
												select="$target-entity-type"/>
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

</xsl:stylesheet>
