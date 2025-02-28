<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xevt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt"
 xmlns:xxml="https://www.daliboris.cz/ns/xproc/xml"
 xmlns:tei = "http://www.tei-c.org/ns/1.0" 
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="common-lib.xpl" />
<!-- <p:import href="../includes/file-system-xpc-lib/src/xproc/file-system-xpc-lib.xpl"  />-->
 
 <p:option name="enable-logging" select="false()" as="xs:boolean" static="true" />
 
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <p:declare-step type="xevt:add-persName-to-speaker">
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
   <p:with-input port="stylesheet" href="../xslt/evt/evt-add-persName-to-speaker.xsl"/>
  </p:xslt>
  
 </p:declare-step>
 
 <p:declare-step type="xevt:move-front">
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
   <p:with-input port="stylesheet" href="../xslt/evt/evt-move-front-to-body.xsl"/>
  </p:xslt>
  
  <xxml:clean-namespaces />
  
 </p:declare-step>
 
 <p:declare-step type="xevt:divide-texts" name="dividing-texts">
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
  <p:option name="output-directory-path" as="xs:string" required="true" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="output-directory-path-uri" select="resolve-uri($output-directory-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <xxml:clean-namespaces />
  
  <p:for-each name="text">
   <p:with-input select="//tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse') or contains(@xml:id, 'preklad')]]" /> 
   <p:add-attribute match="tei:div[@n=' ']" attribute-name="n" attribute-value="&#160;" />
   <p:variable name="id" select="/tei:TEI/tei:text/@xml:id" />
   <p:store href="{$output-directory-path-uri}/{$id}.xml" message="... storing {$output-directory-path-uri}/{$id}.xml" />
  </p:for-each>
  
  <p:identity>
   <p:with-input pipe="source@dividing-texts"/>
  </p:identity>
  
 </p:declare-step>
 
 <p:declare-step type="xevt:include-texts" name="including-texts">
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
  <p:option name="data-file-path" as="xs:string" required="true" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->  
  <p:replace match="/tei:teiCorpus//tei:listPerson">
   <p:with-input port="replacement" href="{$data-file-path-uri}" select="/data/tei:listPerson" />
  </p:replace>
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-change-text-to-include.xsl"/>
  </p:xslt>
  
  <xxml:clean-namespaces />
  
 </p:declare-step>
 
 <p:declare-step type="xevt:tei-to-evt" name="tei-to-evt">
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
  <p:option name="output-directory-path" as="xs:string?" />
  <p:option name="output-file-name" as="xs:string?" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  <p:variable name="output-file-path-uri" select="resolve-uri(concat($output-directory-path, '/', $output-file-name), $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <xevt:add-persName-to-speaker 
   debug-path="{$debug-path}"
   base-uri="{$base-uri}"/>
  
  <xlog:store p:use-when="$enable-logging" 
   output-directory="{$log-output-directory}" 
   base-uri="{$base-uri}" 
   file-name="{$log-file-name}" 
   debug="{$debug}" step="1" />
  
  <p:delete match="//*[@source='#dracor']" />
  <xlog:store p:use-when="$enable-logging" 
   output-directory="{$log-output-directory}" 
   base-uri="{$base-uri}" 
   file-name="{$log-file-name}" 
   debug="{$debug}" step="2" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse')]]">
   <xevt:move-front  />
  </p:viewport>
  <xlog:store p:use-when="$enable-logging" 
   output-directory="{$log-output-directory}" 
   base-uri="{$base-uri}" 
   file-name="{$log-file-name}" 
   debug="{$debug}" step="3" />
  
  
  <xevt:divide-texts
   output-directory-path="{$output-directory-path}"
   debug-path="{$debug-path}"
   base-uri="{$base-uri}"
    />
  <xlog:store p:use-when="$enable-logging" 
   output-directory="{$log-output-directory}" 
   base-uri="{$base-uri}" 
   file-name="{$log-file-name}" 
   debug="{$debug}" step="4" />
  
  <xevt:include-texts data-file-path="{$data-file-path}" 
   debug-path="{$debug-path}"
   base-uri="{$base-uri}" />
  <xlog:store p:use-when="$enable-logging" 
   output-directory="{$log-output-directory}" 
   base-uri="{$base-uri}" 
   file-name="{$log-file-name}" 
   debug="{$debug}" step="5" />
  
  <p:choose>
   <p:when test="not(empty($output-directory-path) or empty($output-file-name))">
    <p:store use-when="not($enable-logging)"
     href="{$output-file-path-uri}" message="... storing {$output-file-path-uri}" />
    <xlog:store p:use-when="$enable-logging" 
     output-directory="{$output-directory-path}" 
     base-uri="{$base-uri}" 
     file-name="{$output-file-name}" 
     debug="true" />   
   </p:when>
  </p:choose>
  
 </p:declare-step>
 
 <p:declare-step type="xevt:validate-hierarchies" name="validating-hierarchies">
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
  <p:option name="output-directory-path" as="xs:string?" />
  <p:option name="output-file-name" as="xs:string?" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  <p:variable name="output-file-path-uri" select="resolve-uri(concat($output-directory-path, '/', $output-file-name), $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:xslt>
   <p:with-input port="source" />
   <p:with-input port="stylesheet" href="../xslt/validation/hierarchy-overview.xsl"/>
  </p:xslt>
  
  <p:store href="{$output-file-path-uri}" message="...storing {$output-file-path-uri}" />
  
  
 </p:declare-step>
 
 <p:declare-step type="xevt:zip" name="zipping">
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
  <p:option name="input-directory-path" as="xs:string?" />
  <p:option name="output-directory-path" as="xs:string?" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:identity />
  
 </p:declare-step>
 
 
 
</p:library>