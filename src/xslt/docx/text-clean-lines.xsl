<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 6, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="href" as="xs:anyURI" required="yes" />
 
 <xsl:preserve-space elements="*"/>
 <xsl:output method="xml" indent="yes"/>
 
 <xsl:template name="xsl:initial-template">
  <lines>
  <xsl:for-each select="tokenize(unparsed-text($href), '\r?\n')">
   <xsl:variable name="text" select="replace(., '^(\d+)?[\s\t]+', '') => replace('(\[.[^\]]*\])([\s\t]+)(.*)', '$1 $3') => replace('[\s\t]+$', '')"/>
   <xsl:if test="$text != ''">
    <line>
     <xsl:value-of select="$text"/>
    </line>    
   </xsl:if>
  </xsl:for-each>
  </lines>
 </xsl:template>
 
</xsl:stylesheet>