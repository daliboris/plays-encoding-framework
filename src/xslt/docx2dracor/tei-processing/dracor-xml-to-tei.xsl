<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 15, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="_dracor-xml-to-tei-teiHeader.xsl"/>
 <xsl:import href="_dracor-xml-to-tei-text.xsl"/>
 
 <xsl:template match="/">
  <TEI xml:id="neolatXXXXXX" xmlns="http://www.tei-c.org/ns/1.0" xml:lang="lat">
   <xsl:apply-templates select="/body/table[1]" />
   <xsl:apply-templates select="/body" />
  </TEI>
 </xsl:template>
 
</xsl:stylesheet>