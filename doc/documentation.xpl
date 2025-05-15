<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xpan="https://www.daliboris.cz/ns/xproc/analysis"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	version="3.0">
	
	<p:import href="../src/includes/xdoc-xpc-lib/src/xproc/xproc-analyzer-3.0.xpl" />
	
	<p:documentation>
		<xhtml:section xml:lang="en">
			<xhtml:h1>Genrate documentation</xhtml:h1>
			<xhtml:p>Generates documentation (README) files for XPRoc files stored in main XProc directory.</xhtml:p>
		</xhtml:section>
		<xhtml:section xml:lang="cs">
			<xhtml:h1>Generování dokumentace</xhtml:h1>
			<xhtml:p>Vytvoří dokumentaci (README soubory) pro soubry XPRoc uložené v hlavní složce projektu.</xhtml:p>
		</xhtml:section>
	</p:documentation>
	
	
	<!-- OUTPUT PORTS -->
	<p:output port="result" primary="true" serialization="map{'indent' : true()}" />
	
	<!-- OPTIONS -->
	<p:option name="debug-path" select="()" as="xs:string?" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
	
	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<!-- PIPELINE BODY -->
	
	<xpan:analyze input-directory="../src/xproc" 
		output-file-stem="README"
		output-directory="."
		debug-path="{$debug-path}" base-uri="{$base-uri}">
		<p:with-option name="documentation-format" select="('markdown', 'html')" />
	</xpan:analyze>
	
	<xpan:analyze input-directory="../run" 
		output-file-stem="README-RUN"
		output-directory="."
		debug-path="{$debug-path}" base-uri="{$base-uri}">
		<p:with-option name="documentation-format" select="('markdown', 'html')" />
	</xpan:analyze>
	
	
</p:declare-step>
