<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xtei="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei"
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xevt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt"
 xmlns:xdc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/dracor"
 xmlns:xxml="https://www.daliboris.cz/ns/xproc/xml"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="common-lib.xpl" />
 <p:import href="evt-play-lib.xpl" />
 <p:import href="dracor-lib.xpl" />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- STEP -->
 <p:declare-step type="xtei:create-person-list" name="creating-person-list">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="include-variants" as="xs:boolean" select="false()" />
  
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:xquery message="... getting listPerson from play (inclidung variants: {$include-variants})">
   <p:with-input port="query" href="../xquery/get-listPerson-from-play.xquery" />
   <p:with-option name="parameters" select="map { 'include-variants' : $include-variants}" />
  </p:xquery>
 
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xtei:add-lang-usage" name="adding-lang-usage">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-add-lang-usage.xsl"/>
  </p:xslt>
  
  
  <!--<xxml:clean-namespaces />-->
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xtei:postprocessing"  name="postprocessing">
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="data-file-path" as="xs:string?" />
  <p:option name="output-directory-path" as="xs:string?" />
  <p:option name="output-file-name" as="xs:string?" />
  
  <!-- PIPELINE BODY -->
  <xdc:tei-to-dracor data-file-path="{$data-file-path}" debug-path="{$debug-path}" base-uri="{$base-uri}">
   <p:with-input pipe="source@postprocessing" />
  </xdc:tei-to-dracor>
  
  <xevt:tei-to-evt 
   output-directory-path="{$output-directory-path}/evt" 
   data-file-path="{$data-file-path}" 
   debug-path="{$debug-path}" 
   base-uri="{$base-uri}" name="evt">
   <p:with-input pipe="source@postprocessing" />
  </xevt:tei-to-evt>
  
  <xevt:validate-hierarchies 
   output-directory-path="{$output-directory-path}/validation"
   output-file-name="{$output-file-name}.html"
   debug-path="{$debug-path}" 
   base-uri="{$base-uri}">
   <p:with-input pipe="source@postprocessing" />
  </xevt:validate-hierarchies>
  
  <xevt:zip input-directory-path="{$output-directory-path}/evt" output-directory-path="{$output-directory-path}/zip" debug-path="{$debug-path}" base-uri="{$base-uri}" />
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xtei:convert" name="converting">
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="data-file-path" as="xs:string?" />
  <p:option name="output-directory-path" as="xs:string?" />
  <p:option name="output-file-name" as="xs:string?" />
  <p:option name="target" as="xs:string*" values="('EVT', 'DraCor', 'text')" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="output-directory-path-uri" select="resolve-uri($output-directory-path, $base-uri)" />
  
  <p:choose>
   <p:when test="$target='DraCor'">
    <xdc:tei-to-dracor data-file-path="{$data-file-path}"  debug-path="{$debug-path}" base-uri="{$base-uri}"/>
   </p:when>
  </p:choose>
  
  <p:choose>
   <p:when test="not(empty($output-directory-path) or empty($output-file-name))">
    <xlog:store output-directory="{$output-directory-path-uri}" base-uri="{$base-uri}" debug="false" file-name="{$output-file-name}.xml" />
   </p:when>
  </p:choose>

  <p:choose>
   <p:when test="$target='text'">
    <xtei:tei-to-text debug-path="{$debug-path}" base-uri="{$base-uri}"/>
   </p:when>
  </p:choose>
  

 </p:declare-step>
 
 <p:declare-step type="xtei:tei-to-text">
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:xslt name="tei-to-text">
   <p:with-input port="stylesheet" href="../xslt/tei/tei-to-text.xsl" />
  </p:xslt>
  
  <p:file-create-tempfile delete-on-exit="true" suffix=".txt"/>
  <p:variable name="href-tempfile-uri" select="xs:anyURI(.)"/>
  
  <p:store href="{$href-tempfile-uri}">
   <p:with-input pipe="result@tei-to-text"/>
  </p:store>
  
  <p:xslt template-name="xsl:initial-template">
   <p:with-input port="stylesheet" href="../xslt/docx/text-clean-lines.xsl" />
   <p:with-option name="parameters" select="map {'href' : $href-tempfile-uri }" />
  </p:xslt>
  
 </p:declare-step>
 
</p:library>