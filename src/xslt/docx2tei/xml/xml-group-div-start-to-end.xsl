<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:xd2dc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor" 
 xmlns:xf="#dracor-functions"
 version="3.0"
 exclude-result-prefixes="xf xs"
 >
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="group"/>
 
 <xsl:variable name="start-regex">^/(.+)_start(=.*)?/$</xsl:variable>
 <xsl:variable name="end-regex">^/(.+)_end/$</xsl:variable>
 <xsl:variable name="start-or-end-regex">^/(.+)_(start|end)(=.*)?/$</xsl:variable>
 <xsl:variable name="start-or-end-regex-template">^/TAG_(start|end)(=.*)?/$</xsl:variable>
 <xsl:variable name="end-regex-template">^/TAG_end/$</xsl:variable>
 <xsl:variable name="prose-verse-regex">^/.[^=]*=(prose|verse)/$</xsl:variable>
 
 

<!-- <xsl:template match="div[DraCor-additions[matches(normalize-space(), $start-regex)]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates mode="group" />
  </xsl:copy>
 </xsl:template>-->
 
 <xsl:template match="div[DraCor-additions[matches(normalize-space(), $start-regex)]]">
  <xsl:variable name="group-name" select="xf:get-name(DraCor-additions[matches(normalize-space(), $start-regex)][1])"/>
  <xsl:variable name="group-form" select="xf:get-form(DraCor-additions[matches(normalize-space(), $start-regex)][1])"/>
  <xsl:variable name="exclude-regex" select="replace($start-or-end-regex-template, 'TAG', $group-name) "/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-adjacent="xf:section-key(., $group-name)">
    <xsl:choose>
     <xsl:when test="current-grouping-key() != ''">
      <div type="{current-grouping-key()}">
       <xsl:if test="exists($group-form)">
        <xsl:attribute name="form" select="$group-form" namespace="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor" />
       </xsl:if>
       <xsl:copy-of select="current-group() except current-group()[self::DraCor-additions[matches(normalize-space(), $exclude-regex)]]"/>
      </div>
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()"/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
 
 <xsl:template match="DraCor-additions[matches(normalize-space(), $start-regex)]" priority="2" use-when="false()" >
  <xsl:variable name="start" select="."/>
  <xsl:variable name="name" select="replace(normalize-space(), $start-regex, '$1')"/>
  <xsl:variable name="end-regex" select="replace($end-regex-template, 'TAG', $name)"/>
  <xsl:variable name="end" select="following-sibling::DraCor-additions[matches(normalize-space(), $end-regex)][1]"/>
  <div type="{$name}">
<!--   <xsl:copy-of select="$start/following-sibling::*[not($end &lt;&lt; .)]" />-->
<!--   <xsl:apply-templates select="$start/following-sibling::*[not($end &lt;&lt; .)]" /> -->
   <xsl:apply-templates select="$start/following-sibling::*[. &lt;&lt; $end]" mode="group" />
  </div>
 </xsl:template>
 
 <xsl:template match="DraCor-additions[matches(normalize-space(), $start-regex)]" priority="2" mode="group" >
  <xsl:variable name="start" select="."/>
  <xsl:variable name="name" select="replace(normalize-space(), $start-regex, '$1')"/>
  <xsl:variable name="end-regex" select="replace($end-regex-template, 'TAG', $name)"/>
  <xsl:variable name="end" select="following-sibling::DraCor-additions[matches(normalize-space(), $end-regex)][1]"/>
  <div type="{$name}">
   <!--   <xsl:copy-of select="$start/following-sibling::*[not($end &lt;&lt; .)]" />-->
   <!--   <xsl:apply-templates select="$start/following-sibling::*[not($end &lt;&lt; .)]" /> -->
   <xsl:apply-templates select="$start/following-sibling::*[. &lt;&lt; $end]" mode="group" /> 
  </div>
 </xsl:template>

 <xsl:template match="DraCor-additions[matches(normalize-space(), $start-regex)]" priority="2" use-when="false()" />
 <xsl:template match="DraCor-additions[matches(normalize-space(), $end-regex)]" priority="2" use-when="false()"  />

 <xsl:template match="div[DraCor-additions[matches(normalize-space(), $start-regex)]]/*" use-when="false()" >
  <xsl:variable name="current" select="."/>
  <xsl:variable name="prev" select="(preceding-sibling::*[self::DraCor-additions[matches(normalize-space(), $start-or-end-regex)]])[last()]"/>
  <xsl:variable name="next" select="(following-sibling::*[self::DraCor-additions[matches(normalize-space(), $start-or-end-regex)]])[1]"/>
  <xsl:choose>
   <xsl:when test="empty($prev)">
    <xsl:copy-of select="." />
   </xsl:when>
   <xsl:when test="empty($next)">
    <xsl:copy-of select="." />
   </xsl:when>
   <xsl:when test="xf:get-name($prev) = xf:get-name($next)">
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:function name="xf:get-name">
  <xsl:param name="element" as="element()?" />
  <xsl:choose>
   <xsl:when test="empty($element)">
    <xsl:value-of select="()"/>
   </xsl:when>
   <xsl:when test="not($element[self::DraCor-additions[matches(normalize-space(), $start-or-end-regex)]])">
    <xsl:value-of select="()"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="replace($element/normalize-space(), $start-or-end-regex, '$1')"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function>
 
 <xsl:function name="xf:get-form" as="xs:string?">
  <xsl:param name="element" as="element()?" />
  <xsl:choose>
   <xsl:when test="empty($element)">
    <xsl:value-of select="()"/>
   </xsl:when>
   <xsl:when test="$element[self::DraCor-additions[matches(normalize-space(), $prose-verse-regex)]]">
    <xsl:value-of select="replace($element/normalize-space(), $prose-verse-regex, '$1')"/>
   </xsl:when>
   <xsl:when test="not($element[self::DraCor-additions[matches(normalize-space(), $start-regex)]])">
    <xsl:value-of select="()"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="'prose'"/> <!-- default value -->
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function>
 
 <xsl:function name="xf:section-key">
  <xsl:param name="current" as="element()" />
  <xsl:param name="group-name" as="xs:string" />
  <xsl:variable name="prev" select="($current[self::DraCor-additions[matches(normalize-space(), $start-or-end-regex)]], $current/preceding-sibling::*[self::DraCor-additions[matches(normalize-space(), $start-or-end-regex)]]) ! xf:get-name(.)"/>
  <xsl:variable name="next" select="($current[self::DraCor-additions[matches(normalize-space(), $start-or-end-regex)]], $current/following-sibling::*[self::DraCor-additions[matches(normalize-space(), $start-or-end-regex)]]) ! xf:get-name(.)"/>
  <xsl:choose>
   <xsl:when test="empty($prev)">
    <xsl:value-of select="''"/>
   </xsl:when>
   <xsl:when test="empty($next)">
    <xsl:value-of select="''"/>
   </xsl:when>
   <xsl:when test="$prev = $group-name and $next = $group-name">
    <xsl:value-of select="$group-name"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="''"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function>
 

</xsl:transform>