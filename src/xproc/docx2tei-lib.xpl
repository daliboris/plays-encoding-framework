<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:hub="http://docbook.org/ns/docbook"
 xmlns:css="http://www.w3.org/1996/css"
 xmlns:xd2t="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei"
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xevt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt"
 xmlns:xtei="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:dxfs="https://www.daliboris.cz/ns/xproc/file-system"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:fs="https://www.daliboris.cz/ns/file-system"
 xmlns:xxml="https://www.daliboris.cz/ns/xproc/xml"
 xmlns:tei = "http://www.tei-c.org/ns/1.0" 
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="../includes/file-system-xpc-lib/src/xproc/file-system-xpc-lib.xpl" />
 <p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="pef-xpc-lib-base.xpl" />
 <p:import href="tei-play-lib.xpl" />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:input-processing" name="input-processing">
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
  <p:option name="data-directory-path" as="xs:anyURI?"  required="false" />
  <p:option name="data-file-path" as="xs:string?" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <dxfs:document-file-info name="info" />
  <p:variable name="file" select="/fs:file" pipe="report@info" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <p:variable name="log-output-directory" select="if(empty($debug-path)) then () else $debug-path || '/docx2tei/' || $file/@stem" />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />
  
  <!-- PIPELINE BODY -->
  <xpef:input-processing debug-path="{$debug-path}" base-uri="{$base-uri}" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
  
  <!-- Apply replacements, save the result and reload it to be applied -->
  <p:xslt name="character-maps">
   <p:with-input port="stylesheet" href="../xslt/common/character-maps.xsl" />
  </p:xslt>
  <p:file-create-tempfile delete-on-exit="true" suffix=".xml"/>
  <p:variable name="href-tempfile-uri" select="string(.)"/>
  <p:store href="{$href-tempfile-uri}">
   <p:with-input pipe="result@character-maps"/>
  </p:store>
  <p:load href="{$href-tempfile-uri}" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl" />
   <p:with-option name="parameters" select="map {'phase' : 1 }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2"  />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl" />
   <p:with-option name="parameters" select="map {'phase' : 2 }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-clean-element-names.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="4" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-fix-element-combinations.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:tei-conversion" name="tei-conversion">
  
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
  <p:option name="data-file-path" as="xs:string?" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <dxfs:document-file-info name="info" />
  <p:variable name="file" select="/fs:file" pipe="report@info" />
  
  <p:variable name="log-output-directory" select="$debug-path || '/docx2tei/' || $file/@stem || '/teiCorpus'" />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />

  <xxml:clean-namespaces />

  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="22" />
    
 </p:declare-step>

 <!-- STEP -->
 <p:declare-step type="xd2t:convert" name="conversion">
  
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
  <p:option name="target" as="xs:string*" values="('TEI', 'text')" />
  <p:option name="data-file-path" as="xs:string?" />
  
  <!-- PIPELINE BODY -->
  <p:choose>
   <p:when test="$target='TEI'">
    <xd2t:tei-conversion debug-path="{$debug-path}" base-uri="{$base-uri}" data-file-path="{$data-file-path}"/>
   </p:when>
  </p:choose>
  
  <p:choose>
   <p:when test="$target='text'">
    <xpef:docx-processing debug-path="{$debug-path}" base-uri="{$base-uri}"/>
   </p:when>
  </p:choose>
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:docx-to-text" use-when="false()">
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
  
  <!-- PIPELINE BODY -->
  
  
 </p:declare-step>

</p:library>