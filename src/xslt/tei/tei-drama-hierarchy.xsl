<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei" version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Sep 22, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>

  <xsl:output method="xml" indent="yes"/>
  <xsl:mode on-no-match="shallow-copy"/>

 <xsl:variable name="parts">
  <lang xml:lang="la">
   <part head="Argumentum" level="1" type="argumentum"  n=" " />
   <part head="Prolusio" level="1" type="act" subtype="prol"/> <!-- prolusio -->
   <part head="Recitativus" level="3" type="num" subtype="recit"/> <!-- recitativus -->
   <part head="Aria" level="3" type="num" subtype="aria"/>
   <part head="Inductio I." level="2" type="scene" n="1"/>
   <part head="Inductio II." level="2" type="scene" n="2"/>
   <part head="Inductio III." level="2" type="scene" n="3"/>
   <part head="Inductio IV." level="2" type="scene" n="4"/>
   <part head="Inductio V." level="2" type="scene" n="5"/>
   <part head="Inductio VI." level="2" type="scene" n="6"/>
   <part head="Inductio VII." level="2" type="scene" n="7"/>
   <part head="Inductio VIII." level="2" type="scene" n="8"/>
   <part head="Inductio IX." level="2" type="scene" n="9"/>
   <part head="Inductio X." level="2" type="scene" n="10"/>
   <part head="Inductio XI." level="2" type="scene" n="11"/>
   <part head="Inductio XII." level="2" type="scene" n="12"/>

   <part head="Scena I." level="2" type="scene" n="1"/>
   <part head="Numerus II." level="2" type="scene" n="2"/>
   <part head="Numerus III." level="2" type="scene" n="3"/>
   <part head="Numerus IV." level="2" type="scene"  n="4"/>
   <part head="Numerus V." level="2" type="scene"  n="5"/>
   <part head="Numerus VI." level="2" type="scene" n="6"/>
   <part head="Numerus VII." level="2" type="scene"  n="7"/>
   <part head="Numerus VIII." level="2" type="scene"  n="8"/>
   <part head="Numerus IX." level="2" type="scene"  n="9"/>
   <part head="Numerus X." level="2" type="scene"  n="10"/>


   <part head="Cantus" level="3" type="num" subtype="cant"/>
   <part head="Epilogus" level="1" type="act" subtype="epil"/>
  </lang>
  <lang xml:lang="cs">
   <part head="Námět" level="1" type="argumentum" n=" "/>
   <part head="Předehra" level="1" type="act" subtype="prol"/>
   <part head="Recitativ" level="3" type="num" subtype="recit"/>
   <part head="Árie" level="3" type="num" subtype="aria"/>
   <part head="1. scéna" level="2" type="scene" n="1"/>
   <part head="2. scéna" level="2" type="scene" n="2"/>
   <part head="3. scéna" level="2" type="scene" n="3"/>
   <part head="4. scéna" level="2" type="scene" n="4"/>
   <part head="5. scéna" level="2" type="scene" n="5"/>
   <part head="6. scéna" level="2" type="scene" n="6"/>
   <part head="7. scéna" level="2" type="scene" n="7"/>
   <part head="8. scéna" level="2" type="scene" n="8"/>
   <part head="9. scéna" level="2" type="scene" n="9"/>
   <part head="10. scéna" level="2" type="scene" n="10"/>
   <part head="11. scéna" level="2" type="scene" n="11"/>
   <part head="12. scéna" level="2" type="scene" n="12"/>
   <part head="Zpěv" level="3" type="num" subtype="cant"/>
   <part head="Epilog" level="1" type="act" subtype="epil"/>
  </lang>
 </xsl:variable>


 <xsl:template match="tei:body/tei:div[tei:head]">
  <xsl:variable name="head" select="
    if (tei:head/*) then
     tei:head/*[1]/normalize-space(.)
    else
     normalize-space(tei:head)"/>
  <xsl:variable name="part" select="$parts//part[@head = $head]"/>
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:if test="$part">
    <xsl:attribute name="type" select="$part/@type"/>
   </xsl:if>
   <xsl:if test="$part/@subtype">
    <xsl:attribute name="subtype" select="$part/@subtype"/>
   </xsl:if>
   <xsl:if test="$part/@level">
    <xsl:attribute name="level" select="$part/@level"/>
   </xsl:if>
   <xsl:choose>
    <xsl:when test="$part/@n">
     <xsl:attribute name="n" select="$part/@n"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:attribute name="n" select="$head" />
    </xsl:otherwise>
   </xsl:choose>
   <xsl:apply-templates/>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
