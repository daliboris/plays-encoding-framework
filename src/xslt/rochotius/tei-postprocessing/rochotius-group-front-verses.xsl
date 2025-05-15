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
   <xd:p><xd:b>Created on:</xd:b> Jun 10, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy" />
 
 <xsl:template match="tei:front">
  <xsl:copy>
   <xsl:for-each-group select="*" group-adjacent="if(self::tei:l) then 1 else 0">
    <xsl:choose>
     <xsl:when test=".[self::tei:l]">
      <tei:div>
      <!--<xsl:apply-templates select="." mode="group" />-->
      <xsl:copy-of select="current-group()" />
      </tei:div>
     </xsl:when>
     <xsl:otherwise>
      <tei:div>
<!--       <xsl:apply-templates select="current-group()" />-->
       <xsl:copy-of select="current-group()" />
      </tei:div>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>