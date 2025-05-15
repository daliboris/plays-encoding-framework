<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Dec 15, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="*[following-sibling::*[1][self::text[@highlight-val][. = ' ']]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:text> </xsl:text>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[. = ' '][tab]" priority="2">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="*" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[@highlight-val][. = ' ']" />
 
 <xsl:template match="text[@highlight-val][not(node())]" />
 
 <xsl:template match="text[. = ' '][not(*)][not(exists(preceding-sibling::*[node()]))]" />
 
 <xsl:template match="Normální[not(node())][preceding-sibling::*[1][self::Normální[not(node())]]]" />
 
</xsl:stylesheet>