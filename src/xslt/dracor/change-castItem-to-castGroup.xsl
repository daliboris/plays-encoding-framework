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
   <xd:p><xd:b>Created on:</xd:b> 2026-07-29</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode name="cast-group" on-no-match="shallow-skip"/>
 <xsl:variable name="colon" select="':'"/>
 <xsl:output indent="yes" />
 
 <!-- roles, that don't have roleDesc and shouldn't be a part of castGroup -->
 <xsl:param name="cast-item-role-exceptions" as="xs:string*" required="yes" />
 
 <!--
  
  <castItem>
     <role>Pedissequae ancillae</role>
     <pc>:</pc>
    </castItem>
    <castItem>
     <role>Hagar</role>
    </castItem>
    <castItem>
     <role>Sipha</role>
    </castItem>
   <castItem>
     <role>Methuben,</role>
     <roleDesc>libitinarius</roleDesc>
    </castItem>
  
  >>
  
  <castGroup>
     <roleDesc>Pedissequae ancillae:</roleDesc>
     <castItem><role>Hagar</role></castItem>
     <castItem><role>Sipha</role></castItem>
    </castGroup>
    <castItem>
     <role>Methuben,</role>
     <roleDesc>libitinarius</roleDesc>
    </castItem>
 -->

 <xsl:template match="tei:castGroup">
  <xsl:copy-of select="." />
 </xsl:template>

 <xsl:template match="tei:castItem[tei:pc[. = $colon]]
  [following-sibling::*[1][self::tei:castItem[not(tei:roleDesc) and tei:role != $cast-item-role-exceptions]]]
  ">
  <castGroup>
   <roleDesc><xsl:value-of select="./tei:role || $colon"/></roleDesc>
   <xsl:apply-templates select="following-sibling::*[1]" mode="cast-group" />
  </castGroup>
 </xsl:template>
 
 <xsl:template match="tei:castItem[not(tei:pc[. = $colon]) and not(tei:roleDesc) and tei:role != $cast-item-role-exceptions]" mode="cast-group">
  <xsl:copy-of select="." />
  <xsl:apply-templates select="following-sibling::*[1]
   [self::tei:castItem[not(tei:roleDesc) and tei:role != $cast-item-role-exceptions]]" 
   mode="#current" />
 </xsl:template>
 
 <xsl:template match="tei:castItem[not(tei:pc[. = $colon]) and not(tei:roleDesc) and tei:role != $cast-item-role-exceptions]
  [preceding-sibling::*[1][self::tei:castItem[tei:pc[. = $colon]]]]
  " />
 
 <xsl:template match="tei:castItem[not(tei:pc[. = $colon]) and not(tei:roleDesc) and tei:role != $cast-item-role-exceptions]
  [let $root := . return every $item in preceding-sibling::tei:castItem[tei:pc[. = $colon]][1]/following-sibling::*[. &lt;&lt; $root]
  satisfies ($item[self::tei:castItem[not(tei:roleDesc) and tei:role != $cast-item-role-exceptions]]) ]
  " />

 <xsl:template match="tei:castList[tei:castItem[tei:pc[. = $colon]]]" use-when="false()">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-starting-with="tei:castItem[tei:pc[. = $colon]]">
    <xsl:choose>
     <xsl:when test=".[self::tei:castItem[tei:pc[. = $colon]]]">
      <castGroup>
       <roleDesc><xsl:value-of select="./tei:role || $colon"/></roleDesc>
       <xsl:copy-of select="current-group()[self::tei:castItem[not(tei:roleDesc)]] except ." />
      </castGroup>
      <xsl:copy-of select="current-group()[not(self::tei:castItem[not(tei:roleDesc)])] except ." />
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>