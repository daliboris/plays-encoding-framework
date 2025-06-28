<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0" />
 <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema" />
 <ns uri="#functions" prefix="f" />

 <title>DraCor schema partial validation</title>

 <xsl:function name="f:is-line-part-valid" as="xs:boolean">
  <xsl:param name="prev" as="element(tei:l)?" />
  <xsl:param name="current" as="element(tei:l)" />
  <xsl:param name="next" as="element(tei:l)?" />

  <xsl:variable name="prev-valid" as="xs:boolean">
   <xsl:choose>
    <!-- default value from DraCor schema -->
    <xsl:when test="$current/@part = 'N'"> 
     <xsl:value-of select="empty($prev) or $prev/@part = ('N', 'I', 'F')" />
    </xsl:when>
    <xsl:when test="empty($current/@part)">
     <xsl:value-of select="empty($prev/@part) or $prev/@part = ('F')" />
    </xsl:when>
    <xsl:when test="$current/@part = 'I'">
     <xsl:value-of select="empty($prev/@part) or $prev/@part = ('N', 'F')" />
    </xsl:when>
    <xsl:when test="$current/@part = 'M'">
     <xsl:value-of select="$prev/@part = ('I', 'M', 'F', 'N')" />
    </xsl:when>
    <xsl:when test="$current/@part = 'F'">
     <xsl:value-of select="$prev/@part = ('I', 'M')" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="false()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>

  <xsl:variable name="next-valid" as="xs:boolean">
   <xsl:choose>
    <!-- default value from DraCor schema -->
    <xsl:when test="$current/@part = 'N'"> 
     <xsl:value-of select="empty($next) or $next/@part = ('N', 'I')" />
    </xsl:when>
    
    <xsl:when test="empty($current/@part)">
     <xsl:value-of select="empty($next/@part) or $next/@part = ('I')" />
    </xsl:when>
    <xsl:when test="$current/@part = 'I'">
     <xsl:value-of select="$next/@part = ('M', 'F')" />
    </xsl:when>
    <xsl:when test="$current/@part = 'M'">
     <xsl:value-of select="$next/@part = ('M', 'F')" />
    </xsl:when>
    <xsl:when test="$current/@part = 'F'">
     <xsl:value-of select="empty($next/@part) or $next/@part = ('N', 'I')" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="false()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>

  <xsl:value-of select="$prev-valid and $next-valid" />

 </xsl:function>

 <xsl:function name="f:is-line-number-valid" as="xs:boolean">
  <xsl:param name="prev" as="element(tei:l)?" />
  <xsl:param name="current" as="element(tei:l)" />
  <xsl:param name="next" as="element(tei:l)?" />
  
  <xsl:variable name="prev-valid" as="xs:boolean">
   <xsl:choose>
    <xsl:when test="empty($prev)">
     <xsl:value-of select="$current/@n eq '1'" />
    </xsl:when>
    <xsl:when test="$current/@n eq '1'">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($prev/@n) + 1 eq xs:integer($current/@n)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($prev/@n) eq xs:integer($current/@n) and ($prev/@part and $current/@part)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="false()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="next-valid" as="xs:boolean">
   <xsl:choose>
    <xsl:when test="empty($next)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="$current/@n eq '1' and $next/@n eq '2'">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($current/@n) + 1 eq xs:integer($next/@n)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="(xs:integer($current/@n) gt xs:integer($next/@n)) and $next/@n eq '1'">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:when test="xs:integer($current/@n) eq xs:integer($next/@n) and ($current/@part and $next/@part)">
     <xsl:value-of select="true()" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="false()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  
  <xsl:value-of select="$prev-valid and $next-valid" />
  
 </xsl:function>


 <pattern>
  <title>Check of subsequent line numbers</title>
  <p>Checks if line are numbered sequentialy and if lines with the same number (@n) contains appropriate value of the @part attribute.</p>
  <rule context="tei:l">
   <let name="prev" value="./preceding::tei:l[1]" />
   <let name="next" value="./following::tei:l[1]" />
   <assert test="@n">
    Line number must be assigned. 
   </assert>
   <assert test="f:is-line-number-valid($prev, ., $next)"> 
    Line numbers must represent sequence (prev: <value-of select="$prev/@n" />, cur: <value-of select="@n" />, next: <value-of select="$next/@n" />) 
   </assert>
   <assert test="if (@part) then f:is-line-part-valid($prev, ., $next) else true()" role="info"> 
    Found sequence <value-of select="$prev/@part" />, <value-of select="@part" />, and <value-of select="$next/@part" />. 
   </assert>
  </rule>
 </pattern>
</schema>
