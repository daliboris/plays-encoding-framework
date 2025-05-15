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
   <xd:p><xd:b>Created on:</xd:b> Jun 11, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="true" />

 
 <xsl:template match="tei:front" use-when="false()">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="*" />
   <xsl:apply-templates select="../tei:body/tei:div[tei:head[. = 'Dramatis personae']]" mode="front"></xsl:apply-templates>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:div[tei:head[. = 'Dramatis personae']]" mode="front">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="type" select="'list-of-persons'"></xsl:attribute>
   <xsl:apply-templates mode="#current" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:head" mode="front">
  <xsl:copy-of select="." />
 </xsl:template>
 
 <xsl:template match="tei:l | tei:p" mode="front">
  <tei:p><xsl:apply-templates /></tei:p>
 </xsl:template>
 
 <xsl:template match="tei:div[tei:head[. = 'Dramatis personae']]" use-when="false()" />
 <xsl:template match="tei:div[tei:head[. = 'Dramatis personae']]">
  <xsl:apply-templates select="." mode="front" />
 </xsl:template>
 
</xsl:stylesheet>