<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 11, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="numbers" select="map {
  '663a' : '663a',
  '663b' : '663c',
  '663c' : '663d',
  '663d' : '663e'
  }"/>
 
 <xsl:template match="tei:l[@n = ('663b', '663c', '663d')]">
  <xsl:copy>
   <xsl:copy-of select="@* except @n" />
   <xsl:attribute name="n" select="map:get($numbers, @n)" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l[@n='663a']">
  <xsl:copy>
   <xsl:attribute name="n" select="@n" />
   <tei:space dim="horizontal" quantity="3" unit="tab"/>
   <xsl:value-of select="substring-before(., ',') => concat(',')"/>
  </xsl:copy>
  <xsl:copy>
   <xsl:attribute name="n" select="'663b'" />
   <tei:space dim="horizontal" quantity="3" unit="tab"/>
   <xsl:value-of select="substring-after(., ', ')"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l[@n = ('271a', '271c', '271d')]">
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <tei:space dim="horizontal" quantity="3" unit="tab"/>
   <xsl:apply-templates />
  </xsl:copy>  
 </xsl:template>
 
</xsl:stylesheet>