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
 
 <xsl:variable name="quotations" select="map {
  'quotation' : map {'type' : 'quotation', 'rend' : 'quotation', 'lbl' : 'Quotation: ' },
  'paraphrase' : map {'type' : 'paraphrase', 'rend' : 'paraphrase', 'lbl' : 'Paraphrase: ' },
  'allusion' : map {'type' : 'allusion', 'rend' : 'allusion', 'lbl' : 'Allusion: ' }
  }"/>
 
 <xsl:variable name="quotations-source" select="map {
  'predecessor' : '(⇐)',
  'successor' : '(⇒)',
  'equal' : '(⇔)'
  }"/>
 
 <xsl:variable name="quotes" select="map {
  'start' : '❠',
  'end' : '❝'
  }"/>
 
 <xsl:key name="app" match="tei:app" use="@from" />
 
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
 
 <xsl:template match="tei:l[tei:anchor[@type='delimiter'][@subtype='quote-start']][not(tei:app[tei:note[tei:cit]])]">
  <xsl:variable name="apps" select="id(tei:anchor[@type='delimiter'][@subtype='quote-start']/@xml:id/substring-before(., '.start'))" />
  <!-- TODO více citací v jednom verši
   rochotius-gedeon-comoedia.app.000075.start, rochotius-gedeon-comoedia.app.000076.start ve verši 141 
  -->
  <!-- TODO: neexistující tei:app k tei:anchor
   rochotius-gedeon-comoedia.app.000068.start ve verši 111
  -->
  <xsl:variable name="app" select="$apps[1]"/>
  <xsl:variable name="app-type" select="($app/tei:note/tei:cit/tei:quote/@type, $app/tei:note/tei:cit/tei:bibl/@type, 'quotation')[1]"/>
  <xsl:variable name="hi-rend" select="$apps/tei:note/tei:cit/tei:*[@type]/@type => distinct-values() => string-join(' ')"/>
  
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:choose>
    <xsl:when test="exists($app)">
     <hi rend="{$hi-rend}">
      <seg xml:id="{$app/@xml:id}.seg-i" part="I" next="#{$app/@xml:id}.seg-f">
       <xsl:attribute name="source" select="string-join($apps/@xml:id, ' ')" />
       <xsl:attribute name="type" select="$app-type" />
       <xsl:attribute name="resp" select="'#' || string-join($editor, ' #')" />
       <xsl:apply-templates />
      </seg>
     </hi>     
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:copy>
  
 </xsl:template>
 
 <xsl:template match="tei:l[tei:app[tei:note[tei:cit]]] | tei:p[tei:app[tei:note[tei:cit]]]">
  <xsl:variable name="apps" select="tei:app[tei:note[tei:cit]]"/>
  <!-- TODO více citací v jednom verši -->
  <xsl:variable name="app" select="$apps[1]"/>
  <xsl:variable name="app-type" select="($app/tei:note/tei:cit/tei:quote/@type, $app/tei:note/tei:cit/tei:bibl/@type, 'quotation')[1]"/>
  <xsl:variable name="hi-rend" select="$apps/tei:note/tei:cit/tei:*[@type]/@type => distinct-values() => string-join(' ')"/>
  
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <hi rend="{$hi-rend}">
    <seg xml:id="{$app/@xml:id}.seg-f" part="F" prev="#{$app/@xml:id}.seg-i">
     <xsl:attribute name="source" select="string-join($apps/@xml:id, ' ')" />
     <xsl:attribute name="type" select="$app-type" />
     <xsl:attribute name="resp" select="'#' || string-join($editor, ' #')" />
     <xsl:apply-templates />
    </seg>
   </hi>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l/tei:app[tei:note[tei:cit]] | tei:p/tei:app[tei:note[tei:cit]]" />
 

 <xsl:template match="tei:app/tei:note/tei:cit/tei:quote" mode="app-back">
  <xsl:variable name="app" select="ancestor::tei:app"/>
  <xsl:variable name="app-type" select="($app/tei:note/tei:cit/tei:quote/@type, $app/tei:note/tei:cit/tei:bibl/@type, 'quotation')[1]"/>
  <xsl:variable name="app-subtype" select="if(exists(@subtype)) then ' ' || $quotations-source?(string(@subtype)) else ''"/>
  
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <label xml:space="preserve"><xsl:value-of select="$quotations?($app-type)?lbl || $app-subtype"/></label>
   <xsl:if test="not($app-type = 'allusion')"><xsl:value-of select="$quotes?start"/></xsl:if>
   <xsl:apply-templates mode="#current" />
   <xsl:if test="not($app-type = 'allusion')"><xsl:value-of select="$quotes?end"/></xsl:if>
  </xsl:copy>
  
 </xsl:template>
 
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