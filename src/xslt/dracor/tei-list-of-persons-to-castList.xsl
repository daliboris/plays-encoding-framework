<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Jan 28, 2026</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:strip-space elements="*"/>
  <xsl:output indent="yes" />
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:mode on-no-match="shallow-skip" name="actor"/>
  <xsl:mode on-no-match="shallow-copy" name="actor-details"/>
  
  <xsl:template match="tei:div[@type='list-of-persons']">
    <castList><xsl:apply-templates /></castList>
  </xsl:template>
  
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p">
    <castItem><xsl:apply-templates /></castItem>
  </xsl:template>
 
 <xsl:template match="tei:div[@type='list-of-persons']/tei:p[tei:ref[@type='actor']]" priority="2">
  <castItem><xsl:apply-templates mode="actor" /></castItem>
 </xsl:template>
  
 <xsl:template match="tei:div[@type='list-of-persons']/tei:p[tei:ref[@type='actor']]/tei:persName" mode="actor" priority="2">
  <xsl:variable name="role-end" select="following-sibling::text()[matches(normalize-space(.), ':$')][1]"/>
  <role><xsl:apply-templates /><xsl:if test="normalize-space($role-end) = ':'"><xsl:value-of select="':'"/> </xsl:if> </role>
  <xsl:if test="exists($role-end) and normalize-space($role-end) != ':'">
   <roleDesc><xsl:apply-templates select="(following-sibling::node()[. &lt;&lt; $role-end], $role-end)" mode="actor-details" /></roleDesc>   
  </xsl:if>
  </xsl:template>
 
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p/tei:persName">
    <role><xsl:apply-templates /></role>
  </xsl:template>
  
  <!--
  <p:delete match="tei:app/tei:rdg" />
  <p:unwrap match="tei:app/tei:lem" />
  <p:unwrap match="tei:app" />
  -->
  
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p/tei:anchor" mode="#all" />
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p/tei:note" mode="#all" />
 <xsl:template match="tei:div[@type='list-of-persons']/tei:p/tei:app"  mode="#all" >
    <roleDesc><xsl:apply-templates select="tei:lem/node()" /></roleDesc>
  </xsl:template>
  
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p/text()[normalize-space(.) != '']">
    <roleDesc><xsl:value-of select="." /></roleDesc>
  </xsl:template>
 
 
 
 <xsl:template match="tei:div[@type='list-of-persons']/tei:p/tei:ref[@type='actor']" mode="actor">
  <actor><xsl:value-of select="."/><xsl:apply-templates select="following-sibling::node()" mode="actor-details" /></actor>
 </xsl:template>
 
 <xsl:template match="tei:div[@type='list-of-persons']/tei:p/text()[normalize-space(.) != '']" mode="actor-details">
  <xsl:value-of select="."/>
 </xsl:template>
  
</xsl:stylesheet>