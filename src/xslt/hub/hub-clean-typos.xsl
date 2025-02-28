<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:css="http://www.w3.org/1996/css"
 xmlns:hub="http://docbook.org/ns/docbook"
 xmlns="http://docbook.org/ns/docbook"
 exclude-result-prefixes="xs math xd hub"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jan 27, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:character-map name="space">
  <xsl:output-character character="&#xa0;" string=" "/>
 </xsl:character-map>
 
 <xsl:output method="xml" indent="yes" use-character-maps="space" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <phrase role="Znaky_pro_pozn_mku_pod__arou">
         <tab/>Rosilus:</phrase>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 
 <xsl:template match="hub:phrase[@role='Znaky_pro_pozn_mku_pod__arou']">
  <xsl:copy>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 

 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <para role="poznamky">
      <superscript role="No_character_style">a</superscript>
      <phrase>
         <tab/>Ct 2,12:</phrase>
      <phrase css:font-style="italic"
              css:font-weight="normal"> Flores apparuerunt in terra tempus putationis advenit / vox turturis audita est in terra nostra.</phrase>
   </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 
 <xsl:template match="hub:phrase[normalize-space(.) = 'Ct 2,12:']">
  <xsl:copy>
   <xsl:copy-of select="hub:tab" />
   <xsl:value-of select="concat(., ' ')"/>
  </xsl:copy>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <para role="zakladni_text"
               css:text-indent="0pt"
               css:text-align="center"
               css:text-align-last="center">
            <phrase css:font-weight="bold"
                    css:font-style="normal"
                    css:font-variant="small-caps">1. scéna</phrase>
         </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para[@role = 'zakladni_text'][@css:text-align='center'][hub:phrase[@css:font-weight='bold'][not(@css:line-height)]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="role" select="'stred-hra-titulek'" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <para role="zakladni_text"
               css:text-indent="0pt"
               css:text-align="center"
               css:text-align-last="center">
            <phrase css:font-weight="bold"
                    css:font-style="normal"
                    css:font-variant="small-caps">1. scéna</phrase>
         </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para[@role = ('hra2-a', 'zakladni_text')][@css:text-align='center'][hub:phrase[@css:font-weight='bold'][not(@css:line-height)][@css:font-variant='small-caps']]" priority="2">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="role" select="'stred-hra-titulek'" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 
 <xsl:template match="hub:para[@role = ('hra2-a')][hub:phrase[@css:font-weight='normal'][@css:font-style='italic'][. != '.']]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="role" select="'hra2-a-stage'"></xsl:attribute>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 

</xsl:stylesheet>