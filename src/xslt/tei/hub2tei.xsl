<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:css="http://www.w3.org/1996/css"
 xmlns:hub="http://docbook.org/ns/docbook"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 17, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" encoding="UTF-8" indent="yes" 
   xpath-default-namespace="http://docbook.org/ns/docbook" />
  <xsl:mode on-no-match="text-only-copy"/>
 
 
 <xsl:key name="poznamky" match="hub:para[starts-with(@role,'poznamky')]" use="hub:superscript" />
 
 <xsl:variable name="cislo-verse-regex" select="'^\d+([ab])?$'"/> <!-- číslo verše; a/b v případě rozdělní mezi dvě scény -->
 
 <xd:doc>
  <xd:desc>
   <xd:p>Oddíl první úrovně se převede na samostatný text.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:section[hub:section]">
  <text xmlns="http://www.tei-c.org/ns/1.0">
   <body>
    <xsl:apply-templates />    
   </body>
  </text>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Oddíl s poznámkami se ze zpracování vypouštějí, neboť se poznámky zařadí na odpovídající místo v textu.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:section[@role='notes']" priority="2" />
  
 <xsl:template match="hub:section[@role='notes'][hub:para[contains(., ']')]]" priority="3">
  <div type="notes">
   <xsl:apply-templates select="hub:para[contains(., ']')]" />
  </div>
 </xsl:template>
 
 <xsl:template match="hub:para[not(node())]" priority="2" />
 
 
 <xd:doc>
  <xd:desc>
   <xd:p>Půlmezera mezi verši odděluje </xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="
  hub:para
  [@role='mezerapul']
  [preceding-sibling::*[1]
  [self::hub:para[not(hub:phrase/@css:text-align) and not(hub:phrase/@css:font-weight)]
  ]
  ]
  [following-sibling::*[1]
  [self::hub:para[not(hub:phrase/@css:text-align) and not(hub:phrase/@css:font-weight)]
  ]
  ]
  " priority="3">
  
  <p class="division" />
 </xsl:template>
 
 <!--
  <para role="hra1-a">
            <phrase css:font-weight="bold"
                    css:font-style="normal">[331r]</phrase>
            <tab/>Venerabor.</para>
         <para role="mezerapul"/>
         <para role="hra1-a">
            <tab/>Eucharus 2:<tab/>
            <tab/>Ergone Eucharus nondum tuis</para>
 -->
 
 <xsl:template match="
  hub:para
  [@role='mezerapul']
  [preceding-sibling::*[1]
  [self::hub:para[normalize-space(.) => ends-with('Venerabor.')]
  ]
  ]
  [following-sibling::*[1]
  [self::hub:para[normalize-space(.) => starts-with('Eucharus 2:')]
  ]
  ]
  " priority="4">
  
  <p class="division" />
 </xsl:template>

 <xd:doc>
  <xd:desc>
   <xd:p>Titul</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para
  [@role=('zakladni_text', 'odstavec')]
  [@css:text-align='center']
  [hub:phrase
   [@css:font-size='12pt']
   [@css:line-height='14pt']
   [@css:font-weight='bold']
   [@css:font-style='normal']
   [not(@css:font-variant)]
  ]">
  <titlePart type="main"><xsl:apply-templates /></titlePart>
 </xsl:template>

 <xd:doc>
  <xd:desc>
   <xd:p>Podtitul</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para
  [@role=('zakladni_text', 'odstavec')]
  [@css:text-align='center']
  [hub:phrase
  [@css:font-size='12pt']
  [@css:line-height='14pt']
  [@css:font-weight='bold']
  [@css:font-style='normal']
  [@css:font-variant='small-caps']
  ]">
  <titlePart type="sub"><xsl:apply-templates /></titlePart>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>O realizaci představení</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para
  [@role=('zakladni_text', 'odstavec')]
  [@css:text-align='center']
  [hub:phrase
  [@css:font-size='12pt']
  [@css:line-height='14pt']
  [not(@css:font-weight)]
  [not(@css:font-style)]
  [not(@role)]
  [not(@css:font-variant)]
  ]">
  <performance>
   <p><xsl:apply-templates /></p>
  </performance>
 </xsl:template>

 <xd:doc>
  <xd:desc></xd:desc>
 </xd:doc>
 <xsl:template match="hub:para">
  <p>
   <xsl:call-template name="transform-css-to-style"/>
   <xsl:apply-templates />
  </p>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Převod formátování definovaného pomocí CSS na atribute <xd:b>@style</xd:b> nadřazeného elementu.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template name="transform-css-to-style">
  <xsl:if test="@css:*">
   <xsl:attribute name="style">
    <xsl:apply-templates select="@css:*"/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Odstavec, který obsahuje výlučně foliaci/paginaci.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:phrase[matches(., '\[\d+[rv]\]')]">
  <pb n="{.}" />
 </xsl:template>

 <xsl:template match="hub:phrase[not(@css:*)]" priority="2">
  <xsl:apply-templates />
 </xsl:template>

 <xsl:template match="hub:phrase[not(@*)]">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="hub:phrase">
  <hi>
   <xsl:call-template name="transform-css-to-style"/>
   <xsl:apply-templates /> 
  </hi>
 </xsl:template>
 
 <xsl:template match="hub:phrase/@css:* | hub:para/@css:*">
  <xsl:value-of select="concat(local-name(), ': ', ., '; ')"/>
 </xsl:template>
 
 <xsl:template match="hub:footnote">
  <note>
   <xsl:attribute name="n">
    <xsl:number count="hub:footnote" from="hub:section" level="any" />
   </xsl:attribute>
   <xsl:apply-templates />
  </note>
 </xsl:template>
 
 <xsl:template match="hub:para[@role='zakladni_text' and @css:text-align='center'][phrase[@css:font-weight='bold']]">
  <head>
   <xsl:apply-templates />
  </head>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Nejspíš chyba v sazbě, jediný případ, kdy jde o nadpis.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para
  [@role='odstavec']
  [@css:text-align='center']
  [hub:phrase
  [@css:font-weight='bold']
  [not(@css:font-size)]
  ]">
  <head>
   <xsl:apply-templates />
  </head>  
 </xsl:template>
 
 <xsl:template match="hub:para[@role='hra1-a'][hub:phrase[@css:font-style='italic']] | hub:para[@role='hra1'][hub:phrase[@css:font-style='italic']]" priority="2">
  <p><xsl:apply-templates /></p>
 </xsl:template>
 
 <xsl:template match="hub:para[@role='hra1-a'] | hub:para[@role='hra1']">
  <l><xsl:apply-templates /></l>
 </xsl:template>
 
 <xsl:template match="hub:para[@role='hra2-a'] | hub:para[@role='hra2']">
  <l><xsl:apply-templates /></l>
 </xsl:template>
 
 <xsl:template match="hub:para[@role='hra2-a-stage']">
  <stage><xsl:apply-templates /></stage>
 </xsl:template>
 
 <xsl:template match="hub:para[hub:informaltable]">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="hub:para/hub:informaltable/hub:tgroup[@cols='4']/hub:tbody[hub:row[1]/hub:entry[1][hub:para/hub:phrase = 'jméno']]" priority="2">
  <listNym>
   <xsl:apply-templates select="hub:row[position() > 1]" />
  </listNym>
 </xsl:template>
 
 <xsl:template match="hub:informaltable/hub:tgroup[@cols='4']/hub:tbody[hub:row[1]/hub:entry[1][hub:para/hub:phrase = 'jméno']]/hub:row[position() > 1]">
  <xsl:apply-templates select="hub:entry[1]" mode="name" />
 </xsl:template>
 
 <xsl:template match="hub:entry/hub:para" mode="name">
  <nym><xsl:apply-templates /></nym>
 </xsl:template>
 
<!-- <xsl:template match="hub:tab[1]" priority="2">
  <space dim="horizontal" quantity="{count(following-sibling::hub:tab) + 1}" unit="tab" />
 </xsl:template>-->
 
 <xsl:template match="hub:tab">
  <space dim="horizontal" quantity="1" unit="tab" />
 </xsl:template>
 
 <xsl:template match="hub:tab[@role='footnotemarker']" />
 
 
 <xsl:template match="hub:para[text()[1][matches(., $cislo-verse-regex)]] | hub:para[hub:phrase[1][text()[1][matches(., $cislo-verse-regex)]]]" priority="2">
  <xsl:variable name="number" select="if(text()[1]/matches(., $cislo-verse-regex)) then text()[1] else hub:phrase[1]/text()[1]"/>
  <l n="{$number}">
   <xsl:apply-templates />
  </l>
 </xsl:template>
 
 <xsl:template match="hub:para/text()[1][matches(., $cislo-verse-regex)]" />
 <xsl:template match="hub:para[not(starts-with(@role, 'poznamky'))]/hub:phrase[1]/text()[1][matches(., $cislo-verse-regex)]" />
 
 <xsl:template match="hub:para[@role = 'stred-hra-titulek']" priority="2">
  <head>
   <xsl:apply-templates />
  </head>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Nadpis v českém překladu hry.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para[@role = 'hra1-a'][@css:text-align='center'][hub:phrase[@css:font-weight='bold']]" priority="2">
  <head>
   <xsl:apply-templates />
  </head>
 </xsl:template>
 
 <xsl:template match="hub:para[starts-with(@role,'poznamky')][hub:superscript[hub:tab[@role='footnotemarker']]]" priority="3">
   <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="hub:para[@role=('odstavec', 'zakladni_text','hra1-a', 'hra1')]/hub:superscript[matches(., '[a-z]')]">
  <xsl:apply-templates select="key('poznamky', .)[1]" mode="poznamky" />
 </xsl:template>
 
 <xsl:template match="hub:para[starts-with(@role,'poznamky')]" mode="poznamky">
  <xsl:variable name="item" select="hub:superscript[1]"/>
  <note n="{$item}">
   <xsl:apply-templates />
  </note>
 </xsl:template>
 
 <xsl:template match="hub:para[starts-with(@role,'poznamky')]" priority="2" />
 

 <xd:doc>
  <xd:desc>
   <p>Poznámka pod čarou s textověkritickým aparátem. Číslo udává řádek verše.</p>
   <p>V rámci zpracování bude potřeba identifikovat verš a odpovídádající pasáž před skobou.</p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para[starts-with(@role,'poznamky')][.//text()[1][matches(., $cislo-verse-regex)]][contains(., ']')]" priority="3">
  <note>
   <xsl:apply-templates />
  </note>
 </xsl:template>
 
 <xsl:template match="hub:footnote/hub:para/hub:superscript[hub:tab[@role='footnotemarker']]">
  <hi style="vertical-align: super; font-size: 75%;">
   <xsl:number count="hub:footnote" from="hub:section" level="any" />
  </hi>
 </xsl:template>
 
 <xsl:template match="hub:superscript">
  <hi style="vertical-align: super; font-size: 75%;"><xsl:apply-templates /></hi>
 </xsl:template>

 <xsl:template match="hub:subscript">
  <hi style="vertical-align: sub; font-size: 75%;"><xsl:apply-templates /></hi>
 </xsl:template>
 
 <xsl:template match="hub:para/text()[ends-with(., ':')][following-sibling::hub:tab]">
  <speaker><xsl:value-of select="."/></speaker>
 </xsl:template>
 
 <xsl:template match="hub:para/hub:phrase/text()[ends-with(., ':')][not(ends-with(., 'podobna Próteovi:'))][preceding-sibling::node()[self::hub:tab]]" priority="3">
  <speaker><xsl:value-of select="."/></speaker>
 </xsl:template>

</xsl:stylesheet>