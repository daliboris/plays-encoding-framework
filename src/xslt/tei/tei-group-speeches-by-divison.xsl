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
   <xd:p><xd:b>Created on:</xd:b> Apr 8, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:output method="xml" indent="yes" exclude-result-prefixes="tei" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:div[tei:p[@class='division']]">
  <xsl:for-each-group select="*" group-adjacent="
   if(self::tei:p[@class='division']) then 0 
   else
   if(self::tei:sp) then 1
   else
   -1">
   <xsl:choose>
    <xsl:when test="current-grouping-key() = 1">
     <tei:div>
      <xsl:copy-of select="current-group()" />
     </tei:div>    
    </xsl:when>
    <xsl:when test="current-grouping-key() = -1">
      <xsl:copy-of select="current-group()" />
    </xsl:when>
    <xsl:when test="current-grouping-key() = 0">
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:for-each-group>
 </xsl:template>
 
 
 
</xsl:stylesheet>