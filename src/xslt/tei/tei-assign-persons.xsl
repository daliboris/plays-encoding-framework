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
   <xd:p><xd:b>Created on:</xd:b> Jan 29, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="data-file-path" as="xs:string" required="yes" />
 
 <xsl:variable name="data-file" select="doc($data-file-path)"/>
 <xsl:key name="speaker" match="variant" use="@text" />
 <xsl:key name="person" match="tei:person" use="tei:persName" />
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:persName[@type='variant']" />
 
 <xsl:template match="tei:sp">
  <!--<xsl:variable name="person" select="key('person', tei:speaker)[1]"/>-->
  <xsl:variable name="person" select="key('speaker', tei:speaker, $data-file)[1]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <!--<xsl:attribute name="who" select="concat('#', $person/@xml:id)" />-->
   <xsl:attribute name="who" select="concat('#', $person/@id)" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>