<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 13, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output method="xml" indent="yes" />
 
 <!--
   <tei:l rend="indent-">
            <tei:space unit="tab"/>Pegasei tutela chori, Phaebique<tei:note n="22"
                      xml:id="rochotius-comoedia.note.000022">
               <tei:p> Phaebus – přízvisko Apollóna, zde v obecném významu „básnické umění“.</tei:p>
            </tei:note> patrone<tei:app>
               <tei:lem>patrone</tei:lem>
               <tei:rdg wit="#JC_A">patrona</tei:rdg>
            </tei:app>,</tei:l>
 -->
 
 <xsl:template match="text()[not(ends-with(., ' '))]
  [following-sibling::node()[1][self::tei:note]]
  [following-sibling::node()[2][self::text()][ends-with(., ' ') or starts-with(., ' ')]]
  [following-sibling::node()[3][self::tei:app[tei:rdg]]]
  " use-when="false()">
  <xsl:variable name="text" select="following-sibling::node()[2]"/>
  <xsl:variable name="lem" select="following-sibling::node()[3][self::tei:app[tei:rdg]]/tei:lem/normalize-space() => replace('\?', '\\?')"/>
  <xsl:value-of select="."/>
  
   
 </xsl:template>
 
 <xsl:template match="text()[following-sibling::node()[1][self::tei:app[tei:rdg]]]">
  <xsl:variable name="lem" select="following-sibling::node()[1][self::tei:app[tei:rdg]]/tei:lem/normalize-space() => replace('\?', '\\?')"/>
  <xsl:value-of select="replace(., concat($lem, ':?$'), '')"/> <!-- :? kvůli emendaci jména postavy -->
  <xsl:if test="replace(., concat($lem, ':?$'), '') = ' '">
   <tei:hi xml:space="preserve" rendition="normal"> </tei:hi>   
  </xsl:if>
 
 </xsl:template>
 
</xsl:stylesheet>