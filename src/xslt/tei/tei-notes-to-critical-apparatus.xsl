<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xdf="https://www.daliboris.cz/ns/xslt/drama/functions"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 exclude-result-prefixes="xs math xd tei xdf"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Mar 30, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:app[tei:note]">
  <xsl:copy>
   <xsl:apply-templates select="tei:note/text()[contains(., ']')]" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:app/tei:note/text()[contains(., ']')]">
  <tei:lem>
   <xsl:value-of select="substring-before(., ']') => normalize-space()"/>
  </tei:lem>
  <tei:rdg>
   <xsl:choose>
    <xsl:when test="parent::tei:note/tei:hi[. = ' AA']">
     <xsl:attribute name="wit" select="concat('#', normalize-space(parent::tei:note/tei:hi[. = ' AA']), '-t-A')" />
    </xsl:when>
   </xsl:choose>
   <xsl:value-of select="substring-after(., ']') => normalize-space()"/>
  </tei:rdg>
 </xsl:template>
 
 <xsl:template match="tei:anchor[following-sibling::tei:app]" />
 <xsl:template match="text()[preceding-sibling::node()[1][self::tei:anchor[following-sibling::tei:app]]]" />
 
</xsl:stylesheet>