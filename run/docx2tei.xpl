<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xd2t="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei"
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="../src/xproc/pef-xpc-lib-base.xpl" />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <p:declare-step type="xd2t:first-function" name="fist-function">
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
   <p:with-input port="stylesheet" href="../Xslt/?.xsl" />
   <p:with-option name="parameters" select="map {'parameter' : 'value' }" />
  </p:xslt>
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/?.?" />
  </p:if>
 
 </p:declare-step>
 
</p:library>