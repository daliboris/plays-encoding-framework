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
   <xd:p><xd:b>Created on:</xd:b> Apr 8, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" exclude-result-prefixes="tei" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:body">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="tei:div[1]" />
   <xsl:apply-templates select="tei:div[@type='act'][@subtype='prol']" />
   <tei:div n=" " type="act">
    <xsl:copy-of select="tei:div[@type='act'][@subtype='prol']//tei:div[@type='scene']" />
   </tei:div>
   <xsl:copy-of select="tei:div[3]" />
   <xsl:copy-of select="tei:trailer" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:div[@type='act'][@subtype='prol']/tei:div[@type='scene']" />
 
</xsl:stylesheet>