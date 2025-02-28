<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:oxy="http://www.oxygenxml.com/oxy"
 exclude-result-prefixes="xs math xd tei oxy"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Mar 30, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" exclude-result-prefixes="tei" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:function name="oxy:get-text-language">
  <xsl:param name="id" as="xs:string"/>
  <xsl:choose>
   <xsl:when test="$id = 'la'">Latin</xsl:when>
   <xsl:when test="$id = 'cs'">Czech</xsl:when>
   <xsl:otherwise><xsl:value-of select="$id"/></xsl:otherwise>
  </xsl:choose>
 </xsl:function>
 
 <xsl:template match="tei:langUsage">
  <xsl:copy>
   <xsl:for-each select="(if (ancestor::tei:TEI) then ancestor::tei:TEI else ancestor::tei:teiCorpus)/distinct-values(descendant-or-self::tei:TEI/@xml:lang)">
    <xsl:variable name="lang" select="."/>
    <tei:language ident="{$lang}"><xsl:value-of select="oxy:get-text-language($lang)"/></tei:language>
   </xsl:for-each>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>