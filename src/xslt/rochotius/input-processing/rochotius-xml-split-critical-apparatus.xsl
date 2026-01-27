<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 3, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="critical-apparatus"/>
 <xsl:output method="xml" indent="yes" />
 <xsl:variable name="rigth-square-bracket" select="']'"/>
 <xsl:variable name="dot" select="'.'"/>
 <xsl:variable name="comma" select="','"/>
 <xsl:variable name="reading" select="'Med.: '"/>
 
 <xsl:template match="footnote[contains(., ']')][not(contains(., '['))]">
  <xsl:copy>
   <xsl:attribute name="tei-data" select="'app'" />
   <xsl:copy-of select="@*" />
   <xsl:apply-templates mode="critical-apparatus" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="footnote-text/text[1][following-sibling::*[1][self::text[@italic='true']]]" mode="critical-apparatus">
  <text tei-data="lem"><xsl:copy-of select="@*" /><xsl:apply-templates /></text>
 </xsl:template>
 
 <xsl:template match="footnote-text/text[contains(., $rigth-square-bracket)]" mode="critical-apparatus" priority="2">
  <xsl:variable name="prev" select="substring-before(., $rigth-square-bracket)"/>
  <xsl:variable name="next" select="substring-after(., $rigth-square-bracket || ' ')"/>
  <xsl:variable name="var" select="if($next = $reading) then $reading else if(contains($next, $dot)) then substring-before($next, $dot) else $next"/>
  <xsl:variable name="comment" select="if($next = $reading) then () else if(contains($next, $dot)) then substring-after($next, $dot || ' ') else ()"/>
  
  <xsl:if test="$prev != ''">
   <text tei-data="lem"><xsl:copy-of select="@*" /><xsl:value-of select="$prev"/></text> 
  </xsl:if>
  <text tei-data="pc" xml:space="preserve"><xsl:copy-of select="@*" /><xsl:value-of select="$rigth-square-bracket || ' '"/></text>
  <xsl:if test="$var != ''">
   <text tei-data="rdg"><xsl:copy-of select="@*" /><xsl:value-of select="$var"/></text>   
  </xsl:if>
  <xsl:if test="not(empty($comment))">
   <text tei-data="note"><xsl:copy-of select="@*" /><xsl:value-of select="$comment"/></text> 
  </xsl:if>
  
 </xsl:template>
 
 <xsl:template match="footnote-text/text[starts-with(., $comma)]
  [preceding-sibling::*[1][self::text[@italic='true']]]
  [following-sibling::*[1][self::text[@italic='true']]]" mode="critical-apparatus">
  <text tei-data="pc"  xml:space="preserve"><xsl:copy-of select="@*" /><xsl:value-of select="$comma || ' '" /></text>
  <text tei-data="rdg"><xsl:copy-of select="@*" /><xsl:value-of select="substring-after(., $comma || ' ')" /></text>
 </xsl:template>
 
 <xsl:template match="footnote-text/text[starts-with(., $dot || ' ')]
  [preceding-sibling::*[1][self::text[@italic='true']]]" mode="critical-apparatus" priority="3" >
  <text tei-data="pc"  xml:space="preserve"><xsl:copy-of select="@*" /><xsl:value-of select="$dot || ' '" /></text>
  <xsl:if test="substring-after(., $dot || ' ') != ''">
   <text tei-data="note"><xsl:copy-of select="@*" /><xsl:value-of select="substring-after(., $dot || ' ')" /></text> 
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="text[@italic='true']" mode="critical-apparatus">
  <xsl:variable name="wit-exists" select="preceding-sibling::*[contains(., $dot)] and preceding-sibling::text[@italic='true']"/>
  <xsl:copy>
   <xsl:choose>
    <xsl:when test="$wit-exists">
     <!--
      <text xml:space="preserve"> nuntius] mutuis </text>
      <text italic="true">G</text>
      <text xml:space="preserve">. </text>
      <text xml:space="preserve" italic="true">Nuncius </text>
      <text>připsáno v tisku rukou.</text>
     -->
     <xsl:attribute name="tei-data" select="'note'" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:attribute name="tei-data" select="'wit'" />
    </xsl:otherwise>
   </xsl:choose>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[.=$dot]" priority="2" mode="critical-apparatus">
  <xsl:copy>
   <xsl:attribute name="tei-data" select="'pc'" />
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[not(@italic)]
  [preceding-sibling::*[1][self::text[contains(., $rigth-square-bracket)]]]
  [following-sibling::*[1][self::text[@italic='true']]]" mode="critical-apparatus">
  <xsl:copy>
   <xsl:attribute name="tei-data" select="'rdg'" />
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[not(@italic)]" mode="critical-apparatus">
  <xsl:copy>
   <xsl:attribute name="tei-data" select="'note'" />
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>