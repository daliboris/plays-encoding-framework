<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="#all"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-28</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <!--
   <tei:div>
    <tei:head><tei:pb n="A7v" xml:id="aquila-toboeus.la.A7v" />Actus I.</tei:head>
   </tei:div>
   <tei:div type="argument">
    <tei:head>Argumentum</tei:head>
    <sp who="#per.prologus-tc-tnl">
     <tei:l>
      <tei:space unit="tab" quantity="2" />Quid actus iste, spectatores, continet,</tei:l>
     <tei:l>
     </sp>
   </tei:div>
  <tei:div type="act" n="I">
    <tei:div type="scene" n="I">
     <tei:head>Actus I. Scena I.</tei:head>
    </tei:div>
  </tei:div>
 -->
 
 <xsl:template match="tei:div[count(*) eq 1][tei:head]
  [following-sibling::*[1][self::tei:div[@type='argument']]]
  [following-sibling::*[2][self::tei:div[@type='act'][count(tei:div[@type='scene']) eq count(*)]]]" />
  
 
 
 <xsl:template match="tei:div[@type='argument']
  [preceding-sibling::*[1][self::tei:div[count(*) eq 1][tei:head]]]
  [following-sibling::*[1][self::tei:div[@type='act'][count(tei:div[@type='scene']) eq count(*)]]]" />
 
 <xsl:template match="tei:div[@type='act'][count(tei:div[@type='scene']) eq count(*)]
  [preceding-sibling::*[1][self::tei:div[@type='argument']]]
  [preceding-sibling::*[2][self::tei:div[count(*) eq 1][tei:head]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="preceding-sibling::*[2]/*" />
   <argument>
    <xsl:copy-of select="preceding-sibling::*[1]/*" /> 
   </argument>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>