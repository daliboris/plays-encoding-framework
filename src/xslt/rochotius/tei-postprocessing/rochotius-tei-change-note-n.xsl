<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Oct 2, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy" />
 
 <xsl:template match="tei:text//tei:note[@xml:id]">
  <xsl:variable name="n" select="count(preceding::tei:note[@xml:id]) + 1"/>
  <xsl:variable name="id" select="substring-before(@xml:id, '.0') || '.' || format-number($n, '000000')"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="id" namespace="http://www.w3.org/XML/1998/namespace" select="$id" />
   <xsl:attribute name="n" select="$n" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>