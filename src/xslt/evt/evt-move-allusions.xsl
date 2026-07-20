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
   <xd:p><xd:b>Created on:</xd:b> 2026-07-11</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="app-back"/>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 
 <xsl:variable name="editor" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[tei:resp[. = 'Editor:']]/(tei:name|tei:persName)/@xml:id"/>
 
 <xsl:template match="tei:text[not(tei:back)]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <back>
    <div>
     <head>Analogues</head>
     <xsl:apply-templates select=".//tei:app[tei:note[tei:cit]]" mode="app-back"  />
    </div>
   </back>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l[tei:app[tei:note[tei:cit]]]">
  <xsl:variable name="app" select="tei:app[tei:note[tei:cit]]"/>
  <xsl:variable name="app-type" select="($app/tei:note/tei:quote/@type, $app/tei:note/tei:cit/tei:bibl/@type, 'quotation')[1]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <seg>
    <xsl:attribute name="source" select="$app/@xml:id" />
    <xsl:attribute name="type" select="$app-type" />
    <xsl:attribute name="resp" select="'#' || $editor" />
    <xsl:apply-templates />
   </seg>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l/tei:app[tei:note[tei:cit]]" />
 
 <xsl:template match="tei:app[tei:note[tei:cit]]" mode="app-back">
  <cit>
   <xsl:copy-of select="@xml:id" />
   <xsl:apply-templates mode="#current" />
  </cit>
 </xsl:template>
 
 <xsl:template match="tei:app/tei:note[tei:cit] | tei:app/tei:note/tei:cit" mode="app-back">
  <xsl:apply-templates mode="#current" />
 </xsl:template>
 
 <xsl:template match="tei:pc" mode="app-back">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="tei:label" mode="app-back">
  <lbl><xsl:apply-templates /></lbl>
 </xsl:template>
 
</xsl:stylesheet>