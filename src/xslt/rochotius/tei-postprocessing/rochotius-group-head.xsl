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
   <xd:p><xd:b>Created on:</xd:b> Jun 9, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy" />
 <xsl:import href="../../common/tei/tei-postprocessing/tei-add-pb.xsl"/>
 
 <xsl:template match="tei:head[not(@n)]" mode="group">
  <tei:div>
   <xsl:copy-of select="@type | @subtype" />
   <tei:head>
    <xsl:copy-of select="@type | @subtype" />
    <xsl:copy-of select="node()" />
   </tei:head>
   <xsl:for-each-group select="current-group() except ." group-starting-with="tei:head[@n = '2']">
    <xsl:choose>
     <xsl:when test=".[self::tei:head]">
      <xsl:apply-templates select="." mode="group" />
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </tei:div>
 </xsl:template>
 
 
 <xsl:template match="tei:body">
  <xsl:copy>
   <xsl:for-each-group select="*" group-starting-with="tei:head[not(@n)]">
    <xsl:choose>
     <xsl:when test=".[self::tei:head]">
      <xsl:apply-templates select="." mode="group" />      
     </xsl:when>
     <xsl:otherwise>
      <tei:front>
        <xsl:apply-templates select="current-group()" />
      </tei:front>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>