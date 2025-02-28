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
   <xd:p><xd:b>Created on:</xd:b> Sep 16, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Sekce, která obsahuje pouze text hry a za ní následuje sekce, která obsahuje poznámkový aparát.</xd:p>
   <xd:p>Poznámkový aparát je potřeba přesunout k textu latinské hry.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:hub/hub:section[count(hub:section) = 1]
  [hub:section[1]/hub:para[1]/hub:phrase[starts-with(., '[')]]
  [following-sibling::*[1][self::hub:section[hub:section[@role='notes']]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
    <xsl:copy-of select="*" />
    <xsl:copy-of select="following-sibling::hub:section[1]/hub:section[@role='notes']" />
  </xsl:copy>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Sekce s poznámkami, které patří k textu v předchozí sekci.</xd:p>
   <xd:p>Předchozí sekce začíná počáteční hranatou závorkou, tj. označením foliace.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="hub:section[@role='notes']
  [../preceding-sibling::*[1]
  [self::hub:section
  [count(hub:section) = 1]
  [hub:section[1]/ hub:para[1]/hub:phrase[starts-with(normalize-space(.), '[')]]
  ]
  ]
  " />
 
 
</xsl:stylesheet>