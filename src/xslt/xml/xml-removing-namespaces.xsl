<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Apr 3, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:character-map name="space">
  <xsl:output-character character="&#xa0;" string=" "/>
 </xsl:character-map>
 
 <xsl:output method="xml" indent="yes" use-character-maps="space" />
 
 <xsl:template match="/">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 
 <xsl:template match="/*" priority="2">
  <xsl:element name="{local-name()}" namespace="{namespace-uri()}">
   <xsl:namespace name="xi" select="'http://www.w3.org/2001/XInclude'" />
   <xsl:apply-templates select="@* | node()"/>
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="tei:*">
  <xsl:element name="{local-name()}" namespace="{namespace-uri()}">
   <xsl:apply-templates select="@* | node()"/>
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="xi:*">
  <xsl:element name="xi:{local-name()}" namespace="http://www.w3.org/2001/XInclude">
   <xsl:apply-templates select="@* | node()"/>
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="*">
   <xsl:element name="{local-name()}" namespace="{namespace-uri()}">
   <xsl:apply-templates select="@* | node()"/>
   </xsl:element>
 </xsl:template>
 
 <!--<xsl:template match="@*">
  <xsl:attribute name="{local-name()}">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>-->
 
 <xsl:template match="@*">
  <xsl:if test="not(starts-with (name(), 'xmlns:'))">
   <xsl:copy-of select="." /> 
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="comment()">
  <xsl:copy-of select="." />
 </xsl:template>
 
 <xsl:template match="processing-instruction()">
  <xsl:copy select="."/>
 </xsl:template>
 

 <xsl:template match="@xml:base"/>

</xsl:stylesheet>