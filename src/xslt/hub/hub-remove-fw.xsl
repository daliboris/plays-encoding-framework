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
   <xd:p>Odstraní odstavce s živým záhlavím. Díky tomu se poznámková aparát dostane k sobě.</xd:p>
  </xd:desc>
 </xd:doc>
 
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" encoding="UTF-8" indent="yes" 
   xpath-default-namespace="http://docbook.org/ns/docbook" />
  <xsl:mode on-no-match="shallow-copy"/>
 
 
 <xd:doc>
  <xd:desc>
   <xd:p>Živé záhlaví v tištěné publikaci.</xd:p>
  </xd:desc>
  <xd:example>
   <para role="NormalParagraphStyle"
    css:text-align="right">
    <phrase css:font-size="7pt"
     css:letter-spacing="0.1em"
     css:text-transform="uppercase">angelus ad aras</phrase>
   </para>
  </xd:example>
 </xd:doc>
 <xsl:template match="hub:para
  [@role='NormalParagraphStyle']
  [hub:phrase
  [@css:font-size='7pt']
  [@css:letter-spacing='0.1em']
  [@css:text-transform='uppercase']
  [. = lower-case(.)]
  ]" />
 
 <xd:doc>
  <xd:desc><xd:p>Živé záhlaví v tištěné publikaci.</xd:p></xd:desc>
  <xd:example>
   <para role="kapitola1">
    <phrase css:font-weight="normal"
     css:font-style="normal"
     css:font-size="7pt"
     css:letter-spacing="0.1em">anděl u oltáře</phrase>
   </para>
  </xd:example>
 </xd:doc>
 <xsl:template match="hub:para
  [@role='kapitola1']
  [hub:phrase
  [@css:font-size='7pt']
  [@css:letter-spacing='0.1em']
  [. = lower-case(.)]
  ]" />

 <xd:doc>
  <xd:desc><xd:p>Prázdný odstavec; nejspíš pro oddělení v poznámkovém aparátu.</xd:p> </xd:desc>
 </xd:doc>
 <xsl:template match="hub:para[@role='NormalParagraphStyle'][not(node())]" />
</xsl:stylesheet>