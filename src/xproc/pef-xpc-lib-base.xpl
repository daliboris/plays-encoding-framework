<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:tei = "http://www.tei-c.org/ns/1.0" 
 xmlns:dxar="https://www.daliboris.cz/ns/xproc/archive"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1>Dictionary Encoding Framework Base Library</xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 
 <p:declare-step type="xpef:input-processing" name="input-processing" xpl:step-type="abstract">
  
  <p:documentation>
   <xhtml:section>
    <xhtml:h2>input-processing</xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- Input ports -->
  <p:input  port="source" primary="true" sequence="true" />
  <p:input port="ticket-in" primary="false" sequence="true">
   <p:empty />
  </p:input>
  
  <!-- Output ports -->
  <p:output port="result" primary="true" sequence="true" />
  <p:output port="ticket-out" primary="false" sequence="true" pipe="ticket-in@input-processing"/>
  
  <!-- Options -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:identity />
  
 </p:declare-step>
 
 <p:declare-step type="xpef:xml-processing" name="xml-processing" xpl:step-type="abstract">
  
  <p:documentation>
   <xhtml:section>
    <xhtml:h2>xml-processing</xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- Input ports -->
  <p:input  port="source" primary="true" sequence="true" />
  <p:input port="ticket-in" primary="false" sequence="true">
   <p:empty />
  </p:input>
  
  <!-- Output ports -->
  <p:output port="result" primary="true" sequence="true" />
  <p:output port="ticket-out" primary="false" sequence="true" pipe="ticket-in@xml-processing"/>
  
  <!-- Options -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- 
  <xpef:xml-conversion />
  <xpef:xml-preprocessing />
  <xpef:xml-block-processing />
  <xpef:xml-inline-processing />
  <xpef:xml-postprocessing />
   -->
  
  <p:identity />
  
 </p:declare-step>
 
</p:library>