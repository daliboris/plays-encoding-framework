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
   <xd:p><xd:b>Created on:</xd:b> Apr 13, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:speaker[not(tei:persName)][not(contains(ancestor::tei:sp/@who, ' '))]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
    <!-- pokud se jedná pouze o 1 postavu -->
<!--    <xsl:if test="not(contains(ancestor::tei:sp/@who, ' '))"> -->
    <xsl:choose>
     <xsl:when test="starts-with(ancestor::tei:sp/@who, '#')">
      <xsl:attribute name="ref" select="ancestor::tei:sp/@who" />
     </xsl:when>
     <xsl:otherwise>
      <xsl:attribute name="ref" select="concat('#', ancestor::tei:sp/@who)" />
     </xsl:otherwise>
    </xsl:choose>
     
    <!--</xsl:if>-->
    <xsl:apply-templates />
   </xsl:element>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>