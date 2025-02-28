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
   <xd:p><xd:b>Created on:</xd:b> May 11, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:*[@style][let $tokens := tokenize( normalize-space(@style), ':|;')[. != ''] return count($tokens) = 2 and $tokens[1] = 'letter-spacing']">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="@style">
  <xsl:variable name="style">
   <xsl:value-of select="normalize-space(.) => 
    replace('font-weight: normal;', '') => 
    replace('font-style: normal;', '') => 
    replace('letter-spacing: 0.01em;', '') =>
    replace('text-indent: 0pt;', '')
    => normalize-space()"/>
  </xsl:variable>
  <xsl:if test="$style != ''">
   <xsl:attribute name="style">
    <xsl:value-of select="$style"/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>
 
</xsl:stylesheet>