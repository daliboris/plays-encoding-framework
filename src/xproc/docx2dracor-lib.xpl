<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:hub="http://docbook.org/ns/docbook"
 xmlns:css="http://www.w3.org/1996/css"
 xmlns:xd2dc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor"
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
 <p:declare-step type="xd2dc:input-processing" name="input-processing">
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
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/xml/fix-dracor-inside-default.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/xml/fix-tab-at-end.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/xml/fix-tab-as-space.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="6" />
  
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
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="10" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl" />
   <p:with-option name="parameters" select="map {'phase' : 1 }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="15"  />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl" />
   <p:with-option name="parameters" select="map {'phase' : 2 }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="20" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-clean-element-names.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="25" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-fix-element-combinations.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="30" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/xml/xml-fix-element-combinations.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="31" />
  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-group-elements-to-div.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="35" />
  
  <p:variable name="sections" select="count(//div/DraCor-additions[matches(normalize-space(), '^/(.+)_start(=.*)?/$')])" />
  
  <xd2dc:apply-xslt repeat="{$sections}" debug-path="{$debug-path}" base-uri="{$base-uri}" >
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-group-div-start-to-end.xsl" />
  </xd2dc:apply-xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="40" />

  
  <xd2dc:apply-xslt repeat="2" debug-path="{$debug-path}" base-uri="{$base-uri}">
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-group-elements-to-div.xsl" />
  </xd2dc:apply-xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="45" />
  
  
  <p:xslt use-when="false()">
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-group-elements-to-div.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="45" />
  
  <p:xslt use-when="false()">
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-group-elements-to-div.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="50" />
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2dc:tei-processing" name="tei-processing">
  
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  <p:input port="job-ticket" primary="false" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
 
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="data-directory-path" as="xs:anyURI?"  required="false" />
  <p:option name="data-file-path" as="xs:string?" />
  <p:option name="text-id" as="xs:string?" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <p:variable name="log-file-name" select="$text-id || '.xml'" />
  <p:variable name="log-output-directory" select="if(empty($debug-path)) then () else $debug-path || '/tei-processing/' || $text-id" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/dracor-xml-to-tei.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/dracor-tei-move-lb.n-attribute.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
  

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/dracor-tei-convert-to-lb.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-add-castItem.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-fix-stage.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="10" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-fix-speaker.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="15" />
  
  <!-- TODO -->
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-split-line-with-speakers.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="16" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-insert-speaker.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="17" />
  
 
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/rochotius/tei-postprocessing/rochotius-add-sp.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="20" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/common/tei-add-who-to-sp.xsl" />
   <p:with-option name="parameters" select="map {'person-prefix' : '' }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="21" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-generate-particDesc.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="22" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-add-l-part.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="25" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-space.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="30" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2dracor/tei-processing/tei-clean-whitespace.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="35" />

  <p:delete match="tei:speaker[@resp='#pef-dracor']" />
  <p:delete match="@xd2dc:*" />
  <p:namespace-delete prefixes="xd2dc" />
  
  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/xml/xml-removing-namespaces.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="50" />
  
 </p:declare-step>
 
 <p:declare-step type="xd2dc:apply-xslt" name="applying-xslt">
  
   <p:input port="source" primary="true"/>
   <p:input port="stylesheet" primary="false"/>
   <p:output port="result" primary="true"/>
   
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="repeat" select="1" as="xs:integer"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <dxfs:document-file-info name="info" />
  <p:variable name="file" select="/fs:file" pipe="report@info" />
  
  <p:variable name="log-output-directory" select="$debug-path || '/apply-xslt/' || $file/@stem"  />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />
   
   <p:choose>
    <p:when test="$repeat gt 1">
      <p:xslt name="apply-xslt">
       <p:with-input port="source" pipe="source@applying-xslt"/>
       <p:with-input port="stylesheet" pipe="stylesheet@applying-xslt"/>
      </p:xslt>
     <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="{$repeat}" />
     <xd2dc:apply-xslt repeat="{$repeat - 1}" debug-path="{$debug-path}" base-uri="{$base-uri}" >
      <p:with-input port="stylesheet" pipe="stylesheet@applying-xslt" />
     </xd2dc:apply-xslt>
    </p:when>
    <p:otherwise>
     <p:xslt name="apply-xslt">
      <p:with-input port="source" pipe="source@applying-xslt"/>
      <p:with-input port="stylesheet" pipe="stylesheet@applying-xslt"/>
     </p:xslt>
     <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
    </p:otherwise>
   </p:choose>
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2dc:tei-conversion" name="tei-conversion">
  
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
  
  <p:variable name="log-output-directory" select="$debug-path || '/docx2dracor/' || $file/@stem"  />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />

  <xxml:clean-namespaces />

  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="20" />
    
 </p:declare-step>

 <!-- STEP -->
 <p:declare-step type="xd2dc:convert" name="conversion">
  
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
    <xd2dc:tei-conversion debug-path="{$debug-path}" base-uri="{$base-uri}" data-file-path="{$data-file-path}"/>
   </p:when>
  </p:choose>
  
  <p:choose>
   <p:when test="$target='text'">
    <xpef:docx-processing debug-path="{$debug-path}" base-uri="{$base-uri}"/>
   </p:when>
  </p:choose>
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2dc:docx-to-text" use-when="false()">
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