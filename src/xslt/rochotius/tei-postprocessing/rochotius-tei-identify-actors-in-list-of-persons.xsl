<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:fn="http://www.w3.org/2005/xpath-functions"
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="#all"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-31</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="../../common/_tei-play-variables.xsl"/>
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
  
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:param name="actors" as="element()*" required="yes" />
 <xsl:param name="project-suffix" select="'tnl'"/>
 
 <xsl:variable name="full-suffix" select="concat('-',  $name-suffix, '-', $project-suffix)"/>
 
 <xsl:variable name="all-actors-names-sorted" select="tnf:sort-elements-by-string-length($actors)"/>
 <xsl:variable name="actors-names" select="string-join($all-actors-names-sorted ! replace(., ' ', '\\s') ! replace(., '\.', '\\.'), '|')"/>
 <xsl:variable name="actor-regex" select="'^(' || $actors-names || ')'"/>
 
 
 <xsl:template match="tei:div[@type = 'list-of-persons']/tei:p/text()[matches(., $actor-regex)]">
  
  <xsl:variable name="text" select="analyze-string(., $actor-regex)/fn:match/fn:group[1]"/>
  <xsl:variable name="text-after" select="substring-after(., $text)"/>
  <xsl:variable name="xml-id" select="tnf:get-valid-xml-id($text, 'act') || $full-suffix"/>
  <tei:ref target="#{$xml-id}" type="actor"><xsl:value-of select="$text"/></tei:ref><xsl:value-of select="$text-after"/>
 </xsl:template>
 
 
</xsl:stylesheet>