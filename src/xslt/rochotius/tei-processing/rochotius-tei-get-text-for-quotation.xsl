<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-23</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <!-- TODO
  případy, kdy je v cestě tei:app/tei:lem
 -->
 <xsl:template match="tei:app/tei:note/tei:cit/tei:quote[not(node())]">
  <xsl:variable name="end" select="ancestor::tei:app"/>
  <xsl:variable name="start" select="id($end/@from/substring-after(., '#'))"/>
  <xsl:variable name="text-items" select="$start/following::node()[. &lt;&lt; $end]"/>
  <xsl:variable name="text" select="if (count($text-items) eq 1) then $text-items else string-join(for $text-item in $text-items[normalize-space() != ''][parent::tei:l] return $text-item , ' / ') => normalize-space()"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:value-of select="$text"/>
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>