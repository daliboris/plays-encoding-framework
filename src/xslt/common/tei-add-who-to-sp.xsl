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
   <xd:p><xd:b>Created on:</xd:b> Jul 11, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="_tei-play-variables.xsl"/>
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:key name="characters" match="tei:person" use="@xml:id" />
 
 <xsl:template match="tei:sp[not(@who)]">
  <xsl:variable name="speaker" select="let $text := if(tei:speaker[tei:app]) then tei:speaker/tei:app/tei:lem else tei:speaker/text()[1] return translate($text/normalize-space(), ' .[]:', '-')"/>
  <xsl:variable name="character-id" select="concat('per.', lower-case($speaker), $full-suffix)"/>
  <xsl:variable name="id" select="if(key('characters', $character-id)) then '#' || $character-id else concat('#per.', lower-case($speaker))"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="who" select="$id" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:speaker/text()[1]">
   <xsl:value-of select="translate(normalize-space(), ':', '')"/>
 </xsl:template>
 
</xsl:stylesheet>