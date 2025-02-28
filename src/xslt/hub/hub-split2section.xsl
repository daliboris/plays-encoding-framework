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
 
 <xsl:template match="hub:hub">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="hub:info" />
   <xsl:for-each-group select="* except hub:info" group-starting-with="
    hub:para[normalize-space(.) = '[329r]'] |
    hub:para[normalize-space(.) = '[330r]'] |
    hub:para[hub:phrase
    [@css:font-size='12pt']
    [@css:line-height='14pt']
    [@css:font-weight='bold']
    [@css:font-style='normal']
    ][normalize-space(.) = 'Anděl u oltáře'] |
    hub:para[hub:phrase
    [@css:font-size='12pt']
    [@css:line-height='14pt']
    [@css:font-weight='bold']
    [@css:font-style='normal']
    ][starts-with(normalize-space(.), 'Hlas volajícího,')] |
    hub:para[normalize-space(.) = '[299v]'] |
    hub:para[normalize-space(.) = '[82r]'] |
    hub:para[normalize-space(.) = '[86v]'] |
    hub:para[not(@css:text-indent)][hub:phrase
    [@css:font-size='12pt']
    [@css:line-height='14pt']
    [@css:font-weight='bold']
    [@css:font-style='normal']
    [@css:font-variant='small-caps']
    ][normalize-space(.) = 'Svatý Jan Nepomucký'] |
    hub:para[starts-with( normalize-space(.), 'II.2')]
    ">
    <section>
     <xsl:copy-of select="current-group()" />
    </section>
   </xsl:for-each-group>
  </xsl:copy>

 </xsl:template>

 
</xsl:stylesheet>