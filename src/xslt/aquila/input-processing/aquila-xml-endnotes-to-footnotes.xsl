<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="#all"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-06-27</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="endnote | endnote-reference | endnoteReference | endnote-text">
  <xsl:element name="{replace(name(), 'endnote', 'footnote')}">
   <xsl:copy-of select="@* except (@id, @n)" />
   <xsl:if test="@id">
    <xsl:attribute name="id" select="concat('end.', @id)" />
   </xsl:if>
   <xsl:if test="@n">
    <xsl:attribute name="n" select="concat('end.', @n)" />
   </xsl:if>
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
</xsl:stylesheet>