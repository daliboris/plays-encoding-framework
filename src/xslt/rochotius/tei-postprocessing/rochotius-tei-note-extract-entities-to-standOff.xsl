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
   <xd:p><xd:b>Created on:</xd:b> Jun 20, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:sourceDesc/tei:listPerson[tei:head[@xml:lang='cs'][. = 'Seznam postav']]">
  
  <tei:listPerson>
   <xsl:copy-of select="." />
   <tei:listPerson xml:id="pb-persons-annotation">
    <tei:head xml:lang="cs">Osoby mimo autoritní zdroje</tei:head>
    <tei:head xml:lang="en">Persons outside authoritative sources</tei:head>
<!--    <xsl:copy-of select="/tei:TEI/tei:text//tei:note/tei:p/tei:person" />-->
    <xsl:copy-of select="/tei:TEI/tei:text//tei:note/tei:person" />
   </tei:listPerson>
  </tei:listPerson>
  
  <tei:listPlace>
<!--   <xsl:copy-of select="/tei:TEI/tei:text//tei:note/tei:p/tei:place" />-->
   <xsl:copy-of select="/tei:TEI/tei:text//tei:note/tei:place" />
  </tei:listPlace>
  
 </xsl:template>
 
 <xsl:template match="tei:text">
  <tei:standOff>
   <tei:list type="glossary">
<!--    <xsl:copy-of select="/tei:TEI/tei:text//tei:note/tei:p/tei:item" />-->
    <xsl:copy-of select="/tei:TEI/tei:text//tei:note/tei:item" />
   </tei:list>
  </tei:standOff>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
<!-- <xsl:template match="tei:note[not(parent::tei:app)][tei:p[tei:person|tei:place|tei:item]][count(tei:p/*) eq 1]" />-->
 <xsl:template match="tei:note[not(parent::tei:app)][tei:person|tei:place|tei:item][count(*) eq 1]" />
 
 <xsl:template match="tei:ref[@type='person']">
<!--  <tei:persName ref="{substring-after(@target, '#')}"><xsl:apply-templates /></tei:persName>-->
  <tei:persName ref="{@target}"><xsl:apply-templates /></tei:persName>
 </xsl:template>
 
 <xsl:template match="tei:ref[@type='place']">
<!--  <tei:placeName ref="{substring-after(@target, '#')}"><xsl:apply-templates /></tei:placeName>-->
  <tei:placeName ref="{@target}"><xsl:apply-templates /></tei:placeName>
 </xsl:template>
 
 <xsl:template match="tei:ref[@type='gloss']">
<!--  <tei:rs type="gloss" ref="{substring-after(@target, '#')}"><xsl:apply-templates /></tei:rs>-->
  <tei:rs type="gloss" ref="{@target}"><xsl:apply-templates /></tei:rs>
 </xsl:template>
 
</xsl:stylesheet>