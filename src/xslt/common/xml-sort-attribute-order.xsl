<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsf="https://www.daliboris.cz/ns/xslt/functions"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"  
  version="3.0">
  
  <!-- Default behaviour: shallow‑copy everything that is not otherwise matched -->
  <xsl:mode on-no-match="shallow-copy"/>
  <!-- contains element name as key and set of attributes in prefered order -->
  <xsl:param name="sort-exceptions" as="map(*)" select=" map {
    'div' : ('type', 'n'),
    'person' : ('xml:id', 'sex', 'role'),
    'personGrp' : ('xml:id', 'sex', 'role')
    }" />
  
  <!-- Match any element, copy it, but output its attributes sorted alphabetically
       (including any namespace prefix that is part of the attribute name). -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:namespace name="" select="namespace-uri(.)" />
      <!-- Sort attributes by the result of name() → "prefix:localName" or just "localName" -->
      <xsl:apply-templates select="@*">
        <xsl:sort select="xsf:get-sorted-attribute-name(.)" />
      </xsl:apply-templates>
      
      <!-- Process child nodes (elements, text, comments, PI) recursively -->
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Simple copy of an attribute – no changes to its value -->
  <xsl:template match="@*">
    <xsl:copy/>
  </xsl:template>
  
  <xsl:function name="xsf:get-sorted-attribute-name" as="xs:string">
    <xsl:param name="attribute" as="attribute()" />
    <xsl:variable name="attribute-name" select="$attribute/name()"/>
    <xsl:variable name="element-name" select="$attribute/parent::*/name()"/>
    <xsl:choose>
      <xsl:when test="map:contains($sort-exceptions, $element-name)">
        <xsl:variable name="element-sort" select="$sort-exceptions?($element-name)"/>
        <xsl:choose>
          <xsl:when test="$element-sort = $attribute-name">
            <xsl:variable name="count" select="count($element-sort) - index-of($element-sort, $attribute-name) + 1"/>
            <xsl:value-of select="string-join((1 to $count) ! '_', '') ||  $attribute-name"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$attribute/name()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
          <xsl:value-of select="$attribute/name()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
</xsl:stylesheet>