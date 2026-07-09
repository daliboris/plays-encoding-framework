<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="#all"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-04</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="page-regex">/?p\.\s\d+/?</xsl:param>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="text[node()[1][matches(., $page-regex)]]">
  <text sz-val="24"
   bold="true"><xsl:value-of select="'[' || translate(node()[1], '/', '') || ']'"/></text>
  <xsl:if test="count(*) gt 0 or count(node()[normalize-space() != '']) gt 1">
   <xsl:copy>
    <xsl:copy-of select="@*" />
    <xsl:apply-templates select="node() except node()[1]" />
   </xsl:copy>   
  </xsl:if>
 </xsl:template>
 
 
</xsl:stylesheet>