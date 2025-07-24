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
   <xd:p><xd:b>Created on:</xd:b> Jun 30, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output method="xml" indent="yes" />
 
 <xsl:template match="tei:body/tei:div[last()][tei:head[starts-with(., 'Finis')]]" />
 <xsl:template match="tei:body/tei:div[last() - 1][following-sibling::*[1][self::tei:div/tei:head[starts-with(., 'Finis')]]]/tei:*[last()]">
  <xsl:copy-of select="." />
  <tei:stage><xsl:apply-templates select="parent::*/following-sibling::tei:div[1]/tei:head/node()" /></tei:stage>
 </xsl:template>
 
</xsl:stylesheet>