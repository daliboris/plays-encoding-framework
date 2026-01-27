<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:math="http://www.w3.org/2005/xpath-functions/math"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	exclude-result-prefixes="xs math xd"
	version="3.0">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> May 6, 2025</xd:p>
			<xd:p><xd:b>Author:</xd:b> Boris</xd:p>
			<xd:p></xd:p>
		</xd:desc>
	</xd:doc>
	
	<xsl:param name="pb-regex">^\[([A-Z]+[a-z]*\d+[rv])\]$</xsl:param>
	
	<xsl:preserve-space elements="*"/>
	<xsl:mode on-no-match="shallow-copy"/>
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="line[matches(., $pb-regex)]" />
	<xsl:template match="line[preceding-sibling::line[1][matches(., $pb-regex)]]">
		<xsl:variable name="pb" select="preceding-sibling::line[1]/normalize-space()"/>
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:value-of select="$pb"/>
			<xsl:text> </xsl:text>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
	
</xsl:stylesheet>