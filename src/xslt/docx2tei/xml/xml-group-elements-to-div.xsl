<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:xd2dc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 16, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:strip-space elements="*"/>
 
 <!-- FIRST ITERATION -->
 <xsl:template match="/body[not(div)]">
  <xsl:copy>
   <xsl:namespace name="xd2dc" select="'https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor'" />
   <xsl:for-each-group select="*" group-starting-with="self::DraCor-additions[normalize-space() = ('/front/', '/main/', '/main=verse/', '/main=prose/', '/back/')]">
    <xsl:choose>
     <xsl:when test=".[self::table]">
      <xsl:copy-of select="." />
     </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="info" select="translate(normalize-space(), '/', '') => tokenize('=')"/>
      <xsl:variable name="type" select="$info[1]"/>
      <xsl:variable name="form" select="($info[2],'prose')[1]"/>
      <div type="{$type}" xd2dc:form="{$form}"><xsl:copy-of select="current-group() except ."/> </div>      
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>   
  </xsl:copy>
 </xsl:template>
 
 <!-- SECOND ITERATION -->
 <xsl:template match="div[@type=('front', 'back')]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-starting-with="self::DraCor-additions">
    <xsl:choose>
     <xsl:when test=".[self::DraCor-additions]">
      <xsl:variable name="info" select="translate(normalize-space(), '/', '') => tokenize('_')"/>
      <xsl:variable name="position" select="( $info[2], 'start')[1]"/>
      <xsl:variable name="type" select="$info[1]"/>
      <xsl:if test="$position = 'start'">
       <div type="{$type}">
        <xsl:copy-of select="current-group() except ." />
       </div>
      </xsl:if>
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
 <!-- SECOND ITERATION -->
 <xsl:template match="div[@type=('main')]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   
   <xsl:for-each-group select="*" group-starting-with="self::DraCor-additions">
    <xsl:choose>
     <xsl:when test=".[self::DraCor-additions[starts-with(normalize-space(), '/act')]]">
      <xsl:variable name="info" select="translate(normalize-space(), '/', '') => tokenize('[\s=,]')"/>
      <xsl:variable name="act" select="$info[.][2]"/>
      <xsl:variable name="scene" select="$info[.][4]"/>
      <xsl:variable name="previous" select="preceding-sibling::DraCor-additions[starts-with(normalize-space(), '/act=' || $act)]"/>
      <div type="act" n="{$act}">
       <div type="scene" n="{$scene}">
        <xsl:copy-of select="current-group() except ." />
       </div>
      </div>
     </xsl:when>
     <xsl:when test=".[self::DraCor-additions]">
      <xsl:variable name="info" select="translate(normalize-space(), '/', '') => tokenize('_')"/>
      <xsl:variable name="position" select="( $info[2], 'start')[1]"/>
      <xsl:variable name="type" select="$info[1]"/>
      <xsl:if test="$position = 'start'">
       
        <xsl:choose>
         <!-- <prologue> / <agument>  -->
         <xsl:when test="current-group()[last()][self::div] and (count(current-group()/*) gt 1)">
          <div type="{$type}">
           <xsl:copy-of select="current-group() except(., current-group()[last()])" />
          </div>
          <xsl:copy-of select="current-group()[last()]" />
         </xsl:when>
         <xsl:otherwise>
          <div type="{$type}">
           <xsl:copy-of select="current-group() except ." />
          </div>
         </xsl:otherwise>
        </xsl:choose>        
      </xsl:if>
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
   
   <xsl:for-each-group select="*" group-starting-with="self::DraCor-additions[starts-with(normalize-space(), '/act')]" use-when="false()">
    <xsl:choose>
     <xsl:when test=".[self::DraCor-additions[starts-with(normalize-space(), '/act')]]">
      <xsl:variable name="info" select="translate(normalize-space(), '/', '') => tokenize('[\s=,]')"/>
      <xsl:variable name="act" select="$info[.][2]"/>
      <xsl:variable name="scene" select="$info[.][4]"/>
      <xsl:variable name="previous" select="preceding-sibling::DraCor-additions[starts-with(normalize-space(), '/act=' || $act)]"/>
       <div type="act" xd2dc:level="{$act}">
        <div type="scene" xd2dc:level="{$scene}">
         <xsl:copy-of select="current-group() except ." />
        </div>
       </div>
      <xsl:choose use-when="false()">
       <xsl:when test="empty($previous)">
        <div type="act" xd2dc:level="{$act}">
         <div type="scene" xd2dc:level="{$scene}">
          <xsl:copy-of select="current-group() except ." />
         </div>
        </div>
       </xsl:when>
       <xsl:otherwise>
        <div type="scene" xd2dc:level="{$scene}">
         <xsl:copy-of select="current-group() except ." />
        </div>
       </xsl:otherwise>
      </xsl:choose>
         
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
 <!-- THIRD ITERATION -->
 <xsl:template match="div[@type=('main')][div[@type='act']]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-adjacent="if(self::div[@type='act']) then xs:int(self::*/@n) else 0">
    <xsl:choose>
     <xsl:when test="current-grouping-key() eq 0">
      <xsl:copy-of select="current-group()" />
     </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="first" select="."/>
      <xsl:copy>
       <xsl:copy-of select="@*" />
       <xsl:copy-of select="current-group()/*" />
      </xsl:copy> 
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>