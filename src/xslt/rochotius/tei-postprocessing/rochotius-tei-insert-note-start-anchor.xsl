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
   <xd:p><xd:b>Created on:</xd:b> Oct 1, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:output indent="true" />
 <xsl:mode on-no-match="shallow-copy"/>


 <xsl:template match="text()[normalize-space() != ''][following-sibling::node()[1][self::tei:note[@xml:id]]]">
  <xsl:variable name="note" select="following-sibling::node()[1]"/>
  <xsl:choose>
   <xsl:when test="contains(., ' ')">
    <xsl:variable name="parts" select="let $text := . return let $spaces := index-of(string-to-codepoints($text), 32) return
     if(empty($spaces)) then $text else if($spaces[last()] = string-length($text)) then (substring($text, 1, $spaces[last() - 1]), substring($text, $spaces[last() - 1]  + 1)) else (substring($text, 1, $spaces[last()]), substring($text, $spaces[last()]  + 1))"/>
    <xsl:for-each select="$parts">
     <xsl:if test="position() = last()">
      <tei:anchor type="delimiter" subtype="note-start" n="{$note/@n}" xml:id="{$note/@xml:id}.start" />
     </xsl:if>
     <xsl:value-of select="."/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <tei:anchor type="delimiter" subtype="note-start" n="{$note/@n}" xml:id="{$note/@xml:id}.start" /><xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template> 
</xsl:stylesheet>