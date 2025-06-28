<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2025-06-27</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>

 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:l">
  <xsl:variable name="preceding" select="preceding::tei:l[position() le 10]"/>
  <xsl:variable name="following" select="following::tei:l[position() le 10]"/>
  
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:choose>
    <xsl:when test="@n" />
    <xsl:when test="empty($preceding)">
     <xsl:attribute name="n" select="'1'" />
    </xsl:when>
    <xsl:when test="$following[4]/@n = '5'">
     <xsl:attribute name="n" select="'1'" />
    </xsl:when>
   </xsl:choose>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>