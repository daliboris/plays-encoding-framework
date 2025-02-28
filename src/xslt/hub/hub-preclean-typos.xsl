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
   <xd:p><xd:b>Created on:</xd:b> Jan 28, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="hub:phrase[. = 'Venit Ros']/hub:phrase[@role='Znaky_pro_pozn_mku_pod__arou']" />
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <phrase css:font-style="italic"
              css:font-weight="normal">Venit Ros</phrase>
      <phrase role="Znaky_pro_pozn_mku_pod__arou"
              css:font-style="italic"
              css:font-weight="normal">ilus.</phrase>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[. = 'Venit Ros'][following-sibling::*[1][self::hub:phrase[@role='Znaky_pro_pozn_mku_pod__arou']]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:apply-templates select="following-sibling::hub:phrase[@role='Znaky_pro_pozn_mku_pod__arou']/node()" />
  </xsl:copy>
 </xsl:template>
 
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    (viz v. 402–403<phrase css:font-style="italic" css:font-weight="normal">,</phrase> 473–474, 649–650)
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[@css:font-weight='normal'][@css:font-style='italic'][. = ',']">
  <xsl:value-of select="data()"/>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <para role="hra2-a">
            <phrase>25<tab/>
               <tab/>Tyto nestálé půvaby jsou jen pomíjivou poctou</phrase>
            <phrase css:font-style="italic"
                    css:font-weight="normal">.</phrase>
         </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[@css:font-weight='normal'][@css:font-style='italic'][. = '.'][preceding-sibling::*[1][self::hub:phrase[not(@*)]]]" />
 
 <xsl:template match="hub:phrase[not(@*)][following-sibling::*[1][self::hub:phrase[@css:font-weight='normal'][@css:font-style='italic'][. = '.']]]">
  <xsl:copy>
   <xsl:apply-templates />
   <xsl:text>.</xsl:text>
  </xsl:copy>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <para role="hra2-a"
               css:text-align="center"
               css:text-align-last="center">
            <tabs>
               <tab align="left"
                    alignment-char="."
                    leader=""
                    horizontal-position="34pt"/>
               <tab align="left"
                    alignment-char="."
                    leader=""
                    horizontal-position="104.85pt"/>
               <tab align="left"
                    alignment-char="."
                    leader=""
                    horizontal-position="124.7pt"/>
               <tab align="left"
                    alignment-char="."
                    leader=""
                    horizontal-position="134pt"/>
               <tab align="left"
                    alignment-char="."
                    leader=""
                    horizontal-position="158pt"/>
            </tabs>
            <phrase css:font-weight="bold"
                    css:font-style="normal"
                    css:font-variant="small-caps">2. scéna</phrase>
         </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 
 <xsl:template match="hub:para/hub:tabs" />
 
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
       <para role="hra1-a">
         <phrase css:font-weight="bold" css:font-style="normal">[336v]<tab/></phrase>
         <phrase>Aemulus 5:<tab/>Inauspicata res tibi profecto accidit.</phrase>
      </para>
     <para role="hra2-a">
         <phrase css:font-weight="bold"
                 css:font-style="normal">[92v]<tab/>
         </phrase>
         <phrase>Theolater:<tab/>Precor, Joannes, vota fortunet Polus.</phrase>
     </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[starts-with(. , '[')][hub:tab]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="node() except hub:tab" />
  </xsl:copy>
  <xsl:if test="not(following-sibling::*[1][self::hub:phrase])">
   <tab />
  </xsl:if>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
       <para role="hra1-a">
         <phrase css:font-weight="bold" css:font-style="normal">[336v]<tab/></phrase>
         <phrase>Aemulus 5:<tab/>Inauspicata res tibi profecto accidit.</phrase>
      </para>
     <para role="hra2-a">
         <phrase css:font-weight="bold"
                 css:font-style="normal">[92v]<tab/>
         </phrase>
         <phrase>Theolater:<tab/>Precor, Joannes, vota fortunet Polus.</phrase>
     </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[preceding-sibling::*[1][self::hub:phrase[starts-with(. , '[')][hub:tab]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <tab />
   <xsl:copy-of select="node()" />
  </xsl:copy>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <phrase css:font-style="italic" css:font-weight="normal"> AA.</phrase>
    <phrase css:font-style="italic" css:font-weight="normal"> AA</phrase>.
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[@css:font-style='italic'][@css:font-weight='normal'][. = ' AA.']">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:value-of select="substring-before(., '.')"/>
  </xsl:copy>
  <xsl:value-of select="'.'"/>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <para role="hra2-a"
               css:text-align="center"
               css:text-align-last="center">
            <phrase css:font-weight="bold"
                    css:font-style="normal"
                    css:font-variant="small-caps">5.</phrase>
            <phrase css:font-weight="bold"
                    css:font-style="normal"
                    css:font-variant="small-caps">scéna</phrase>
         </para>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[@css:font-weight='bold'][@css:font-variant='small-caps'][following-sibling::*[1][self::hub:phrase[. = 'scéna']]]">
  <xsl:copy>
    <xsl:copy-of select="@*" />
    <xsl:apply-templates />
   <xsl:text> </xsl:text>
   <xsl:apply-templates select="following-sibling::*[1][self::hub:phrase]" mode="content" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="hub:phrase[@css:font-weight='bold'][@css:font-variant='small-caps'][. = 'scéna'][preceding-sibling::*[1][self::hub:phrase[. = '5.']]]" mode="content">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="hub:phrase[@css:font-weight='bold'][@css:font-variant='small-caps'][. = 'scéna'][preceding-sibling::*[1][self::hub:phrase[. = '5.']]]" />
 
 
 <xd:doc>
  <xd:desc><xd:p>Označnení postavy latinským jménem v českém překladu.</xd:p> </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para[@role='hra1-a'][normalize-space(.) = 'Joannes:Přichází Eucharus.']/text()[. = 'Joannes:']">
  <xsl:value-of select="'Jan:'"/>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:pre>
    <phrase css:letter-spacing="-0.02em">neboť je zločinnější</phrase>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="*[@css:letter-spacing]">
  <xsl:copy>
   <xsl:copy-of select="@* except @css:letter-spacing" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="hub:para[@role='hra1-a'][contains(normalize-space(.), 'Mihi rependi.')]">
  <xsl:copy-of select="." />
  <para role="mezerapul"/>
 </xsl:template>
 
 <xsl:template match="hub:para[@role='hra1-a'][contains(normalize-space(.), 'zaplatit.')]">
  <xsl:copy-of select="." />
  <para role="mezerapul"/>
 </xsl:template>
 
</xsl:stylesheet>