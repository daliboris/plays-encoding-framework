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
   <xd:p><xd:b>Created on:</xd:b> Apr 25, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>

 <xsl:variable name="numbers" select="map {
  272 : '271a', 
  273 : '271b',
  274 : '271c',
  275 : '271d',
  630 : '629a',
  631 : '629b',
  632 : '629c',
  633 : '629d',
  634 : '629e',
  664 : '663a',
  665 : '663b',
  666 : '663c',
  667 : '663d',
  668 : '664'
  }"/>


 <xsl:template match="
  tei:l[@n = ('272', '273', '274', '275', '630', '631', '632', '633', '634', '664', '665', '666', '667', '668')]
  ">
  <xsl:variable name="n" select="@n"/>
  <xsl:variable name="count" select="count(preceding::tei:l[@n = $n])">
  </xsl:variable>
 <xsl:choose>
  <xsl:when test="$count = 0">
   <xsl:copy>
    <xsl:copy-of select="@* except @n" />
    <xsl:attribute name="n" select="map:get($numbers, number(@n))" />
    <xsl:apply-templates />
   </xsl:copy>   
  </xsl:when>
  <xsl:otherwise>
   <xsl:copy-of select="." />
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>
 
 <xsl:template match="tei:l[contains(@n, 'a')] | tei:l[contains(@n, 'b')] ">
  <xsl:copy>
   <xsl:copy-of select="@* except @n" />
   <xsl:attribute name="n" select="translate(@n, 'ab', '')" />
   <xsl:attribute name="part" select="translate(@n, 'ab1234567890', 'IF')" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>