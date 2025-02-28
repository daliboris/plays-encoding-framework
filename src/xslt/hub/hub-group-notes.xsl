<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:css="http://www.w3.org/1996/css"
 xmlns:hub="http://docbook.org/ns/docbook"
 xmlns="http://docbook.org/ns/docbook"
 exclude-result-prefixes="xs math xd hub"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Sep 16, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="hub:section">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-adjacent="if(self::hub:para[starts-with(@role, 'poznamky')]) then 0 else if(self::hub:para[hub:mediaobject] or self::hub:para[@role='popisky-obr']) then 1 else 2">
    <xsl:choose>
     <xsl:when test="current-grouping-key() = 0">
      <hub:section role="notes">
       <xsl:copy-of select="current-group()" />      
      </hub:section>
     </xsl:when>
     <xsl:when test="current-grouping-key() = 1">
      <hub:section role="figure">
       <xsl:copy-of select="current-group()" />      
      </hub:section>
     </xsl:when>
     <xsl:otherwise>
      <hub:section role="text">
      <xsl:copy-of select="current-group()" />
      </hub:section>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>

 </xsl:template>
 
 
</xsl:stylesheet>