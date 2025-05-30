<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jul 6, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:param name="pb-regex" select="'/p\.\s(\d+)/'"/>
 
 <xsl:template match="tei:p[matches(., $pb-regex)] | tei:l[matches(., $pb-regex)]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:analyze-string select="." regex="{$pb-regex}">
    <xsl:matching-substring>
     <tei:pb n="{regex-group(1)}" />
    </xsl:matching-substring>
    <xsl:non-matching-substring>
     <xsl:value-of select="."/>
    </xsl:non-matching-substring>
    <xsl:fallback></xsl:fallback>
   </xsl:analyze-string>
  </xsl:copy>
   
 </xsl:template>
 
</xsl:stylesheet>