<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Default behaviour: shallow‑copy everything that is not otherwise matched -->
  <xsl:mode on-no-match="shallow-copy"/>
  
  <!-- Match any element, copy it, but output its attributes sorted alphabetically
       (including any namespace prefix that is part of the attribute name). -->
  <xsl:template match="*">
    <xsl:copy>
      <!-- Sort attributes by the result of name() → "prefix:localName" or just "localName" -->
      <xsl:apply-templates select="@*">
        <xsl:sort select="name()" />
      </xsl:apply-templates>
      
      <!-- Process child nodes (elements, text, comments, PI) recursively -->
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Simple copy of an attribute – no changes to its value -->
  <xsl:template match="@*">
    <xsl:copy/>
  </xsl:template>
  
</xsl:stylesheet>