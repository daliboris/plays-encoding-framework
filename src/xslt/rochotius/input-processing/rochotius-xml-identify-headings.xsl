<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	exclude-result-prefixes="xd"
	version="3.0">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> 2026-01-09 21:01:14.</xd:p>
			<xd:p><xd:b>Author:</xd:b> Boris</xd:p>
			<xd:p></xd:p>
		</xd:desc>
	</xd:doc>
	
	<xsl:param name="headings" as="element(heading)*" required="yes" />
	<xsl:output omit-xml-declaration="no" indent="yes"/>
	<xsl:mode on-no-match="shallow-copy"/>
	<xsl:mode name="heading" on-no-match="shallow-copy"/>
	
	<xsl:variable name="headings-regex" select="'^' || for-each($headings, function($heading) {
		replace($heading, '\s', '\\s') 
		=> replace('\.', '\\.') 
		}) => string-join('|^') "/>
	
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
    <xd:doc>
        <xd:desc>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
	<xsl:template match="body/*[@jc-val='center'][matches(normalize-space(), $headings-regex)]">
        <xsl:copy>
        	<xsl:copy-of select="@*" />
        	<xsl:attribute name="tei-data" select="'heading'" />
        	<xsl:apply-templates mode="heading" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tab" mode="heading" />
    
</xsl:stylesheet>