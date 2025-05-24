<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 23, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:strip-space elements="*"/>
 <xsl:output method="xml" indent="yes" />
 
 <xsl:template match="tei:l[tei:speaker]">
  <xsl:variable name="root" select="."/>
  <xsl:for-each-group select="node()" group-starting-with="tei:speaker">
   <xsl:choose>
    <xsl:when test=".[self::tei:speaker]">
     <xsl:copy-of select=".[self::tei:speaker]" />
     <xsl:element name="{name($root)}" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:copy-of select="$root/@*" />
      <xsl:copy-of select="current-group() except ." />
     </xsl:element>
    </xsl:when>
    <xsl:when test=".[self::tei:milestone[@unit='speech']]">
     <xsl:element name="{name($root)}" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:copy-of select="$root/@*" />
      <xsl:attribute name="part" />
      <xsl:copy-of select="current-group() except ." />
     </xsl:element>
    </xsl:when>
    <xsl:otherwise>
     <xsl:copy-of select="current-group()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:for-each-group>
 </xsl:template>
 
</xsl:stylesheet>