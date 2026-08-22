<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-31</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:argument[not(node())]
  [preceding-sibling::*[1][self::tei:opener]]
  [following-sibling::*[1][self::tei:closer]]" />
 
 <xsl:template match="tei:closer
  [preceding-sibling::*[1][self::tei:argument[not(node())]]]
  [preceding-sibling::*[2][self::tei:opener]]
  [*[1][self::tei:salute]]">
  <tei:p>
   <xsl:apply-templates select="tei:salute/node()" />
  </tei:p>
 </xsl:template>
 
 
</xsl:stylesheet>