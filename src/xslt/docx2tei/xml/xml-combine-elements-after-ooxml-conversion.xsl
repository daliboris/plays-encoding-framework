<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 6, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>

 <xsl:param name="phase" as="xs:integer" select="1" />
 
 <xsl:strip-space elements="*"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output method="xml" indent="yes"/>

 <xsl:template match="/*/*[not(self::comment)]">
  <xsl:copy>
   <xsl:copy-of select="@*"/>
    <xsl:choose>
     <xsl:when test="$phase = 1">
      <xsl:call-template name="copy-and-combine" />
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates />
     </xsl:otherwise>
    </xsl:choose>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template name="copy-and-combine">
  
   <xsl:for-each-group select="*" group-adjacent="
     concat(name(.), '=', string-join(for $att in ./@* except @xml:space
     return
      concat(name($att), '+', data($att))))">
    <xsl:element name="{substring-before(current-grouping-key(), '=')}">
     <xsl:copy-of select="current-group()/@*"/>
     <xsl:copy-of select="current-group()/node()"/>
    </xsl:element>
   </xsl:for-each-group>
 </xsl:template>
  

 <xsl:template match="comment/* | footnote/*">
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:choose>
    <xsl:when test="$phase = 2">
     <xsl:call-template name="copy-and-combine" />    
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>