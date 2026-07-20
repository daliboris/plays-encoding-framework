<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-03</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="persons" as="element()*" required="yes" /> <!-- tei:person, tei:personGrp -->
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 
 <xsl:variable name="person-names" select="string-join($persons/tei:persName ! replace(., ' ', '\\s'), '|')"/>
 <xsl:variable name="person-regex" select="'^(' || $person-names || ')$'"/>
 <xsl:variable name="person-ids" select="$persons/@xml:id"/>
 
 <xsl:key name="person-by-id" match="tei:person" use="@xml:id" />
 
<!-- <xsl:template match="tei:person">
  <xsl:comment> <xsl:value-of select="$person-regex"/> </xsl:comment>
 </xsl:template>-->
 
 <xsl:template match="tei:person[not(matches(tei:persName, $person-regex))]">
  <xsl:variable name="id" select="@xml:id"/>
  <xsl:variable name="existing-external" select="$persons[@xml:id = $id]" as="element(tei:person)?"/>
  <xsl:choose>
   <xsl:when test="exists($existing-external)">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:copy-of select="$existing-external/@* except @xml:id" />
     <xsl:copy-of select="tei:persName" />
     <xsl:copy-of select="$existing-external/tei:persName" />
     <xsl:apply-templates select="* except tei:persName" />
    </xsl:copy>  
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="tei:person[matches(tei:persName, $person-regex)]">
  
  <xsl:variable name="id" select="@xml:id"/>
  <xsl:variable name="existing-external" select="$persons[@xml:id = $id]"/>
  <xsl:variable name="person-name" select="tei:persName"/>
  <xsl:variable name="person" select="$persons[tei:persName = $person-name]"/>
  <xsl:variable name="existing-internal" select="key('person-by-id', $person/@xml:id) except ."/>
  <xsl:if test="empty($existing-internal)">
   <xsl:copy>
    <xsl:copy-of select="@*" />
    <xsl:copy-of select="$person/@* except @xml:id" />
    <xsl:apply-templates />
   </xsl:copy>   
  </xsl:if>
 </xsl:template>
 
 
</xsl:stylesheet>