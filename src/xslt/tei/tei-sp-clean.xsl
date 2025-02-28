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
   <xd:p><xd:b>Created on:</xd:b> May 8, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:sp[@who='#'][contains(., 'Codr. omnes')] | tei:sp[@who='#'][contains(., 'Všichni žebr.')]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="who" select="(for $i in (1 to 3) return concat('#per.codrus-', $i)) => string-join(' ')" />
    <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:sp[@who='#per.omnes'][contains(., 'Omnes')] | tei:sp[@who='#per.omnes'][contains(., 'Všichni')]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="who" select="(for $i in (2 to 4) return concat('#per.eucharus-', $i)) => string-join(' ')" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:speaker/text()[contains(., 'Gen.')]">
  <xsl:value-of select="replace(., 'Gen\.', 'Genius')"/>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Vynechána odpovídající poznámka (Gen. Joannis = Genius Joannis, Gen. Euchari = Genius Euchari)</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:note[contains(., 'Gen.')]" />
 
 <xsl:template match="tei:speaker/text()[contains(., 'Euch.')]">
  <xsl:value-of select="replace(., 'Euch\.', 'Euchara')"/>
 </xsl:template>
 
 <xsl:template match="tei:speaker/text()[contains(., 'Codr.')]">
  <xsl:value-of select="replace(., 'Codr\.', 'Codri')"/>
 </xsl:template>
 
 <xsl:template match="tei:note[contains(., 'Codr.')]" />
 
 <xsl:template match="tei:speaker/text()[contains(., 'Soudce žebr.')]">
  <xsl:value-of select="replace(., ' Soudce žebr\.', ' Soudce žebráků')"/>
 </xsl:template>
 
 <xsl:template match="tei:speaker/text()[contains(., ' men.')]">
  <xsl:value-of select="replace(., ' men\.', ' mendicorum')"/>
 </xsl:template>
 
</xsl:stylesheet>