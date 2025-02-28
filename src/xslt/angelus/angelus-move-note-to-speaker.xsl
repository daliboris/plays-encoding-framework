<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
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
  
 <xsl:template match="tei:speaker[
  following-sibling::tei:l[1]/tei:space
  [following::node()[1][normalize-space(.) = '']]
  [following-sibling::*[1][self::tei:note]]
  ]
  |
  tei:speaker[
  following-sibling::tei:l[1]/tei:space
  [following-sibling::node()[1][self::tei:note]]
  ]
  ">
  <xsl:copy>
   <xsl:copy-of select="@* | node()" />
   <xsl:copy-of select="following-sibling::tei:l[1]/tei:space
    [following-sibling::*[1][self::tei:note]]
    [following::node()[1][normalize-space(.) = '']]/following-sibling::tei:note[1]
    |
    following-sibling::tei:l[1]/tei:space
    [following-sibling::node()[1][self::tei:note]]
    /following-sibling::tei:note[1]
    " />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:note[preceding-sibling::*[1]
  [self::tei:space
  [following::node()[1][normalize-space(.) = '']]]
  ]
  |
  tei:note[preceding-sibling::node()[1]
  [self::tei:space]
  ]
  " />
 
</xsl:stylesheet>