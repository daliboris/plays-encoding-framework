<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xdf="https://www.daliboris.cz/ns/xslt/drama/functions"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 exclude-result-prefixes="xs math xd tei xdf"
 version="3.0">
 
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Apr 7, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy" />

 <xsl:param name="editor" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[tei:resp[. = 'Editor:']]/tei:name"/>
 
 <xsl:variable name="regex" select="'\[.[^\]]*\]'"/>
 
 <xsl:template match="tei:front//text()[matches(., $regex)] | tei:body//text()[matches(., $regex)]">
  <xsl:analyze-string select="." regex="{$regex}">
   <xsl:matching-substring>
    <tei:supplied resp="#{$editor/@xml:id}">
     <xsl:value-of select=". => translate('[]', '')"/> 
    </tei:supplied>
   </xsl:matching-substring>
   <xsl:non-matching-substring>
    <xsl:value-of select="."/>
   </xsl:non-matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 
</xsl:stylesheet>