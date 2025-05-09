<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:hub="http://docbook.org/ns/docbook"
 xmlns:css="http://www.w3.org/1996/css"
 xmlns:xh2t="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/hub2tei"
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
 <p:import href="tei-play-lib.xpl" />

 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- STEP -->
 <p:declare-step type="xh2t:input-processing" name="input-processing">
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
  
  <dxfs:document-file-info name="info" />
  <p:variable name="file" select="/fs:file" pipe="report@info" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <p:variable name="log-output-directory" select="$debug-path || '/hub2tei/' || $file/@stem" />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />
  
  <!-- PIPELINE BODY -->
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/hub/hub-remove-fw.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
 
  <p:xslt>
   <p:with-input port="stylesheet" href="../Xslt/hub/hub-split2section.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
 
  <p:xslt>
   <p:with-input port="stylesheet" href="../Xslt/hub/hub-group-notes.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/hub/hub-move-sections.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="4" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../Xslt/hub/hub-preclean-typos.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../Xslt/hub/hub-clean-typos.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="6" />
  
  <p:delete match="hub:section[@role='figure']" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="7" />
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xh2t:tei-conversion" name="tei-conversion">
  
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
  
  <p:variable name="log-output-directory" select="$debug-path || '/hub2tei/' || $file/@stem || '/teiCorpus'" />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />

  <p:viewport match="hub:hub/hub:section">
   <xh2t:section-to-tei 
    data-file-path="{$data-file-path-uri}"
    position="{p:iteration-position()}"
    debug-path="{$debug-path}" base-uri="{$base-uri}" />
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
  
  <p:rename  new-name="tei:teiCorpus" match="hub:hub" />
  <p:add-attribute match="tei:teiCorpus" attribute-name="xml:lang" attribute-value="la" />
  <p:delete match="tei:teiCorpus/@version" />
  <p:delete match="tei:teiCorpus/@css:version" />
  <p:delete match="tei:teiCorpus/@css:rule-selection-attribute" />
  
  <p:insert match="tei:teiCorpus" position="first-child">
   <p:with-input port="insertion" href="{$data-file-path-uri}" select="//tei:teiHeader" />
  </p:insert>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-text-kind-of.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />
  
  <xxml:clean-namespaces />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="4" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]">
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-arrange-play-hierarchy.xsl"/>
   </p:xslt>
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]" name="play-text">
   <!--  <xdp:create-person-list name="person-list" />-->
   <!--  <xdp:clean-namespaces p:message="Cleaning namespaces" />-->
   
   <p:load href="{$data-file-path-uri}" />
   <p:filter select="/data/tei:listPerson" name="person-list"/>
   <p:wrap match="tei:listPerson" wrapper="tei:particDesc" />
   <xxml:clean-namespaces />
   <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="data-file-listPerson.xml" debug="{$debug}" />
   
   
   <p:replace match="//tei:listPerson">
    <p:with-input port="source" pipe="current@play-text" />
    <p:with-input port="replacement" pipe="@person-list" />
   </p:replace>
   
   <p:insert match="tei:teiHeader/tei:profileDesc" position="first-child" use-when="false()">
    <p:with-input port="source" pipe="current@play-text" />
    <p:with-input port="insertion" pipe="@person-list" />
   </p:insert>
  </p:viewport>
  <xxml:clean-namespaces />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="6" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Synopse')]]">
   <p:delete match="tei:listPerson[@source='#evt'][not(node())]" />
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="7" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]">
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-assign-persons.xsl"/>
    <p:with-option name="parameters" select="map {'data-file-path' : $data-file-path-uri }" />
   </p:xslt>
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="8" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]" >
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-assign-line-number-iterating.xsl"/>
    <p:with-option name="parameters" select="map {'data-file-path' : $data-file-path-uri }" />
   </p:xslt>
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="9" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]/tei:text/tei:body" use-when="true()">
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-assign-note-by-line.xsl"/>  
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory}/notes" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-notes-to-critical-apparatus.xsl"/>  
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory}/notes" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-speaker-remove-colon.xsl"/>
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory}/notes" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />
   
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="10" />
  
  <p:documentation>
   <p>Vloženým zpěvohrám přiřadí samostatné číslování</p>
  </p:documentation>
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]" >
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/angelus/angelus-assign-line-number-cantus.xsl"/>  
   </p:xslt>
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/angelus/angelus-divide-line-in-cantus.xsl"/>  
   </p:xslt>
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="11" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]">
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-square-brackets-to-supplied.xsl"/>
   </p:xslt>
   
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="12" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]">
   <p:variable name="log-output-directory-inner" select="$log-output-directory || 'divisions'" />
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-separate-cantus-div.xsl"/>
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory-inner}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-divide-speech.xsl"/>
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory-inner}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-group-speeches-by-divison.xsl"/>
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory-inner}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-arrange-div-hieararchy.xsl"/>
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory-inner}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="4" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-add-n-to-num-divs.xsl"/>  
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory-inner}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-add-n-to-intermediate-divs.xsl"/>  
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory-inner}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="6" />
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-group-sp-without-div.xsl"/>  
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory-inner}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />

  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="12" />
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]">
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/angelus/angelus-move-note-to-speaker.xsl"/>
   </p:xslt>
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="13" />
  
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse')]]">  
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-pb-add-id.xsl"/>
   </p:xslt>
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="14" />
  
  <p:documentation>
   <p>Změna odsazení textu. Mezery (elementy <b>space</b>) ve verších se redukují na měnší počet:</p>
   <ul>
    <li>jedna mezera (<b>@quantity="1")</b> se odstraňuje (původně šlo o kombinaci poznámky nebo paginy a textu)</li>
    <li>dvě mezery jsou bezpříznakové (odsazení kvůli sazbě), takže se ruší</li>
    <li>3 a více mezer se nahrazují mezerami, jejichž počet je snížen o 1</li>
   </ul>
   <p>Odstraní se také odstavec, který obsahuje pouze element <b>space</b>.</p>
  </p:documentation>
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse')]]" use-when="true()">  
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/angelus/angelus-normalize-indentation-spaces.xsl"/>
   </p:xslt>
   
   <!-- TODO -->
   <p:xslt use-when="false()">
    <p:with-input port="stylesheet" href="../Xslt/angelus-add-spaces-to-cantus.xsl"/>
   </p:xslt>
   
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="15" />
  
  <p:documentation>
   <p>Přiřazení obrázků ke stranám, pouze u originálního textu, netýká se překladu.</p>
   <p>Vytvoří se element <b>facsimile</b> se seznamem souborů s obrázky jednotlivých stran.</p>
   <p>V elementu <b>pb</b> se vytvří atrubut <b>@facs</b> s odkazem na soubor s obrázkem odpovídající strany.</p>
   <p>Jako parametry lze nastavit:</p>
   <ul>
    <li><i>path</i>: výchozí cestu k souborům (musí končit lomítkem);</li>
    <li><i>extension</i>: přípponá souborů (bez úvodní tečky)</li>
   </ul>
   <p>Jméno se generuje z identifikátoru elementu <b>pb</b> přidáním výchozí cesty a přípony.</p>
  </p:documentation>
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Synopse')]]">  
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-add-facsimile.xsl"/>
   </p:xslt>
   
   <xxml:clean-namespaces />
   
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="16" />
  
  <p:delete match="tei:div/@level" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="17" />
  
  <p:delete match="tei:div/*[position() =last()][self::tei:p[@class='division']]" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="18" />
  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-cleaning-markup.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="19" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-add-rend-to-space.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="20" />
  
  <xtei:add-lang-usage />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="21" />
  
  <p:documentation>
   <p>Rozepíše odkazy na více postav</p>
   <p>Rozepíše zkrácené podoby jmen postav (Euch., Gen.), odstraní odpoídající poznámky.</p>
   <p>Verše, které nemají přiřazenou postavu, seskupí a přiřadí jim nejbližší postavu.</p>
  </p:documentation>
  
  <p:viewport match="tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]">
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-sp-clean.xsl"/>
   </p:xslt>
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/tei/tei-sp-ad-missing.xsl"/>
   </p:xslt>
   
  </p:viewport>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="22" />
    
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xh2t:section-to-tei" name="section-to-tei">
  
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
  <p:option name="position" as="xs:integer" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <dxfs:document-file-info name="info" />
  <p:variable name="file" select="/fs:file" pipe="report@info" />

  <p:variable name="log-output-directory" select="$debug-path || '/hub2tei/' || $file/@stem || '/section-' || $position" />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/hub2tei.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-clean-formatting.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-group-elements.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-arrange-elements.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="4" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-group-vertical-space.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-clean-elements.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="6" />
  
  
  <p:insert match="tei:front">
   <p:with-input port="insertion" href="{$data-file-path-uri}" select="/data/tei:text" />
  </p:insert>
  
  <p:xslt use-when="false()">
   <p:with-input port="stylesheet" href="../xslt/nepomuk/nepomuk-add-editorial-to-front.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="7" />  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-group-speeches.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="8" />  

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-move-division-p.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="9" />  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-move-trailer.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="10" />  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-move-pb.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="11" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-drama-hierarchy.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="12" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-synopsis-add-n-to-div.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="13" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-move-trailer.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="14" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-drama-hierarchy-missing-levels.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="15" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-move-trailer.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="16" />
  
  <p:xslt parameters="map{'level': 3 }">
   <p:with-input port="stylesheet" href="../xslt/tei/tei-drama-hierarchy-missing-levels-n.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="17" />


  <p:xslt parameters="map{'level': 2 }">
   <p:with-input port="stylesheet" href="../xslt/tei/tei-drama-hierarchy-missing-levels-n.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="18" />
  
  <p:xslt parameters="map{'level': 1 }" use-when="false()">
   <p:with-input port="stylesheet" href="../xslt/tei/tei-drama-hierarchy-missing-levels-n.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="19" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-div-notes.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="20" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-group-speaker-divs.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="21" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/angelus/angelus-group-speaker-divs-correct.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="22" />
  
  <p:wrap match="tei:text" wrapper="tei:TEI" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="23" />
  
  <p:insert match="tei:TEI" position="first-child">
   <p:with-input port="insertion" href="{$data-file-path-uri}" select="//tei:teiHeader" />
  </p:insert>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="24" />
  
  <xxml:clean-namespaces />
  
 </p:declare-step>
 
</p:library>