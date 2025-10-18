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
   <xd:p><xd:b>Created on:</xd:b> Oct 3, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:hi[@rendition='bold'][following-sibling::node()[1]/normalize-space()=''][following-sibling::node()[2][self::tei:hi[@rendition='bold']]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:apply-templates select="following-sibling::node()[2][self::tei:hi[@rendition='bold']]/node()" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:hi[@rendition='bold'][preceding-sibling::node()[1]/normalize-space()=''][preceding-sibling::node()[2][self::tei:hi[@rendition='bold']]]" />
 
 <xsl:template match="tei:hi[@rendition='bold'][following-sibling::node()[1][self::tei:hi[@rendition='bold']]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:apply-templates select="following-sibling::node()[1][self::tei:hi[@rendition='bold']]/node()" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:hi[@rendition='bold'][preceding-sibling::node()[1][self::tei:hi[@rendition='bold']]]" />
 
 
</xsl:stylesheet>