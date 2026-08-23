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
      <xd:p><xd:b>Created on:</xd:b> Jan 29, 2026</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:param name="divs" required="yes" />
  <xsl:param name="specific-type" as="xs:string*" select="('dedication', 'epigraph')" />
  
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:mode on-no-match="shallow-copy" name="sp"/>
  <xsl:mode on-no-match="shallow-copy" name="opener"/>
  <xsl:mode on-no-match="shallow-skip" name="closer"/>
  <xsl:mode on-no-match="shallow-copy" name="closer-and-argument"/>
  <xsl:mode on-no-match="shallow-copy" name="epigraph"/>
  <xsl:mode on-no-match="shallow-skip" name="epigraph-bibl"/>
  
  <xsl:strip-space elements="*"/>
  <xsl:output indent="yes" />
  
 <xsl:variable name="div-heads" select="$divs[not(self::div[@type='titlePage'])]/*[1]/normalize-space(string-join(text()))"/>
<!-- <xsl:variable name="div-heads" select="$divs/*[1]/normalize-space(string-join(text()))"/>-->
  
  <xsl:template match="tei:div[@type='titlePage' and $divs[self::div[@type='titlePage']]]" priority="2">
    <xsl:variable name="div" select="$divs[self::div[@type='titlePage']]" />
    <xsl:copy-of select="$div/tei:titlePage" />
  </xsl:template>
  
  <xsl:template match="tei:div[*[1]/normalize-space(string-join(text(), ' ')) = $div-heads]">
    <xsl:variable name="head" select="*[1]" />
    <xsl:variable name="head-text" select="$head/normalize-space(string-join(text(), ' '))" />
   <xsl:variable name="div" select="$divs[*[1]/normalize-space(string-join(text())) = $head-text]" />
   <xsl:variable name="element-name" select="if(exists($div/@element)) then $div/@element else if($div/@type= ('titlePage', 'epigraph', 'closer')) then $div/@type else name()" />
<!--    <xsl:variable name="element-name" select="name()"/>-->
    
    <xsl:element name="{$element-name}">
      <xsl:copy-of select="@* except @subtype" />
      <xsl:if test="$element-name = 'tei:div'">
        <xsl:copy-of select="$div/@*" />        
      </xsl:if>
      <xsl:choose>
        <xsl:when test="$div/@type = 'titlePage'">
          <xsl:copy-of select="$div/tei:titlePage/@*" />
          <xsl:copy-of select="$div/tei:titlePage/node()" />
        </xsl:when>
        <xsl:when test="$div/sp[@who]">
          <xsl:copy-of select="$head" />
          <sp>
            <xsl:copy-of select="$div/sp/@*" />
            <xsl:apply-templates mode="sp" />
          </sp>
        </xsl:when>
        <xsl:when test="$div/@type = 'dedication'">
          <xsl:apply-templates mode="opener" />
          <xsl:if test="tei:p[not(ancestor::tei:note)]">
            <closer><salute><xsl:apply-templates mode="closer" /></salute></closer>  
          </xsl:if>
        </xsl:when>
        <xsl:when test="$div/@type = 'epigraph'">
          <cit>
            <quote><xsl:apply-templates mode="epigraph" /></quote>
            <bibl><xsl:apply-templates mode="epigraph-bibl" /></bibl>
          </cit>
        </xsl:when>
        <xsl:when test="$div/@type = 'closer'">
          <xsl:choose>
            <xsl:when test="tei:argument">
              <xsl:apply-templates mode="closer-and-argument" select="tei:head" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates mode="closer" />
            </xsl:otherwise>
          </xsl:choose>
         
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
    <xsl:if test="$div/@type = 'closer' and tei:argument">
      <tei:closer>
        <xsl:apply-templates mode="closer" select="tei:argument" />
      </tei:closer>
    </xsl:if>
    
  </xsl:template>
  
  <xsl:template match="tei:head" mode="sp" />
  
  <xsl:template match="tei:head" mode="opener">
    <opener><salute><xsl:apply-templates mode="#current" /></salute></opener>
  </xsl:template>
  <xsl:template match="tei:p[not(ancestor::tei:note)]" mode="opener" />
  
  <xsl:template match="tei:p[not(ancestor::tei:note)]" mode="closer">
    <xsl:if test="position() ne 1 and position() != last()"><lb /></xsl:if>
    <xsl:apply-templates /><xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:head" mode="closer-and-argument">
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="tei:argument[count(tei:p) eq 1]" mode="closer">
    <xsl:apply-templates select="tei:p/node()" />
  </xsl:template>

  
  <xsl:template match="tei:head" mode="epigraph">
    <p><xsl:apply-templates /></p>
  </xsl:template>
  
  <xsl:template match="tei:p[not(ancestor::tei:note)]" mode="epigraph" />
  
  <xsl:template match="tei:p[not(ancestor::tei:note)]" mode="epigraph-bibl">
    <xsl:if test="position() ne 1 and position() != last()"><lb /></xsl:if>
    <xsl:apply-templates /><xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:template>
  
</xsl:stylesheet>