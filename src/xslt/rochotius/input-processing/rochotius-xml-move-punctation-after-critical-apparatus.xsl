<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 4, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:variable name="rigth-square-bracket" select="']'"/>
 <xsl:variable name="end-punctation-regex" select="'(\p{P})$'"/>
 <xsl:key name="footnote" match="footnote" use="@id" />
 
 
 <xsl:template match="body/*/*/text()[last()][matches(., $end-punctation-regex)][following::*[1][self::footnote-reference]]">
  <xsl:variable name="foot-ref" select="following::*[1]"/>
  <xsl:variable name="id" select="$foot-ref/*/@id"/>
  <xsl:variable name="note" select="key('footnote', $id)"/>
<!--  <xsl:variable name="current" select="."/>-->
  <xsl:choose>
   <xsl:when test="$note[@tei-data='app']">
     
     <xsl:analyze-string select="." regex="{$end-punctation-regex}">
      <xsl:matching-substring>
<!--       <xsl:element name="{name($current)}">-->
<!--        <xsl:copy-of select="$current/@*" />-->
        <xsl:copy-of select="." />
       <!--</xsl:element>-->
      </xsl:matching-substring>
      <xsl:non-matching-substring>
<!--       <xsl:element name="{name($current)}">-->
<!--        <xsl:copy-of select="$current/@*" />-->
        <xsl:copy-of select="." />
        <xsl:copy-of select="$foot-ref" />
       <!--</xsl:element>-->
      </xsl:non-matching-substring>
     </xsl:analyze-string>
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="body/*/footnote-reference[preceding-sibling::*[1][matches(., '\p{P}$')]]">
  <xsl:variable name="id" select="*/@id"/>
  <xsl:variable name="note" select="key('footnote', $id)"/>
  <xsl:choose>
   <xsl:when test="$note[@tei-data='app']">
    
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
</xsl:stylesheet>