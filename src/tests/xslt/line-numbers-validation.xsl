<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:f="#functions"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 28, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:function name="f:is-line-number-valid" as="xs:boolean">
  <xsl:param name="prev" as="element(tei:l)?" />
  <xsl:param name="current" as="element(tei:l)" />
  <xsl:param name="next" as="element(tei:l)?" />
  
  <xsl:variable name="prev-valid" as="xs:boolean">
   <xsl:choose>
    <xsl:when test="empty($prev)">
     <xsl:message select="'empty($prev)'" />
     <xsl:value-of select="$current/@n eq '1'" />
    </xsl:when>
    <xsl:when test="$current/@n eq '1'">
     <xsl:message select="'$current/@n eq 1'" />
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($prev/@n) + 1 eq xs:integer($current/@n)">
     <xsl:message select="'xs:integer($prev/@n) + 1 eq xs:integer($current/@n)'" />
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($prev/@n) eq xs:integer($current/@n) and ($prev/@part and $current/@part)">
     <xsl:message select="'xs:integer($prev/@n) eq xs:integer($current/@n) and ($prev/@part and $current/@part)'" />
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="false()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="next-valid" as="xs:boolean">
   <xsl:choose>
    <xsl:when test="empty($next)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="$current/@n eq '1' and $next/@n eq '2'">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($current/@n) + 1 eq xs:integer($next/@n)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="(xs:integer($current/@n) gt xs:integer($next/@n)) and $next/@n eq '1'">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($current/@n) eq xs:integer($next/@n) and ($current/@part and $next/@part)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="false()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  
  <xsl:value-of select="$prev-valid and $next-valid" />
  
 </xsl:function>
 
</xsl:stylesheet>