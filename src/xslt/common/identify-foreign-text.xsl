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
   <xd:p><xd:b>Created on:</xd:b> 2026-08-21</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:param name="foreign-text-regex" as="xs:string" required="yes" />
 <xsl:param name="language-code" as="xs:string" required="yes" />
 <xsl:param name="element-name" as="xs:string" required="yes" />
 
 <xsl:template match="text()[matches(., $foreign-text-regex)]">
  <xsl:param name="root" select="parent::*"/>
  <xsl:analyze-string select="." regex="{$foreign-text-regex}">
   <xsl:matching-substring>
    <xsl:element name="{$element-name}" namespace="{namespace-uri($root)}">
     <xsl:attribute name="xml:lang" select="$language-code" />
     <xsl:if test="string-length(.) != string-length(normalize-space(.))">
      <xsl:attribute name="xml:space" select="'preserve'" />
     </xsl:if>
     <xsl:value-of select="."/>
    </xsl:element>
   </xsl:matching-substring>
   <xsl:non-matching-substring>
    <xsl:value-of select="."/>
   </xsl:non-matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 
 
</xsl:stylesheet>