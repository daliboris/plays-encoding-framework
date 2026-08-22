<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
   <title>ISO Schematron rules (DraCor Schema 1.6.0)</title>
   <!-- This file generated 2026-08-03T00:03:52Z by 'extract-isosch.xsl'. -->
   <!-- ********************* -->
   <!-- namespaces, declared: -->
   <!-- ********************* -->
   <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
   <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
   <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
   <ns prefix="rna" uri="http://relaxng.org/ns/compatibility/annotations/1.0"/>
   <ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
   <ns prefix="sch1x" uri="http://www.ascc.net/xml/schematron"/>
   <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
   <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
   <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
   <ns prefix="rna" uri="http://relaxng.org/ns/compatibility/annotations/1.0"/>
   <ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
   <ns prefix="sch1x" uri="http://www.ascc.net/xml/schematron"/>
   <!-- ******************************************************** -->
   <!-- constraints in en, und, mul, zxx, of which there are 115 -->
   <!-- ******************************************************** -->
   <pattern id="schematron-constraint-CMC_generatedBy_within_post-1">
      <rule context="tei:*[@generatedBy]">
         <assert test="ancestor-or-self::tei:post">The @generatedBy attribute is for use within a &lt;post&gt; element.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-att-datable-w3c-when-2">
      <rule context="tei:*[@when]">
         <report test="@notBefore|@notAfter|@from|@to" role="nonfatal">The @when attribute cannot be used with any other att.datable.w3c attributes.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-att-datable-w3c-from-3">
      <rule context="tei:*[@from]">
         <report test="@notBefore" role="nonfatal">The @from and @notBefore attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-att-datable-w3c-to-4">
      <rule context="tei:*[@to]">
         <report test="@notAfter" role="nonfatal">The @to and @notAfter attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-only_1_ODD_source-5">
      <rule context="tei:*[@source]">
         <let name="srcs" value="tokenize( normalize-space(@source),' ')"/>
         <report test="(   self::tei:classRef                                 | self::tei:dataRef                                 | self::tei:elementRef                                 | self::tei:macroRef                                 | self::tei:moduleRef                                 | self::tei:schemaSpec )                                   and                                   $srcs[2]"> When used on a schema description element (like &lt;<value-of select="name(.)"/>&gt;), the @source attribute should have only 1 value. (This one has <value-of select="count($srcs)"/>.)</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-targetLang-6">
      <rule context="tei:*[not(self::tei:schemaSpec)][@targetLang]">
         <assert test="@target">@targetLang should only be used on &lt;<name/>&gt; if @target is specified.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-spanTo-points-to-following-7">
      <rule context="tei:*[ starts-with( @spanTo, '#') ]">
         <assert test="id( substring( @spanTo, 2 ) ) &gt;&gt; ."> The element indicated by @spanTo (<value-of select="@spanTo"/>) must follow the current &lt;<name/>&gt; element.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-schemeVersionRequiresScheme-8">
      <rule context="tei:*[@schemeVersion]">
         <assert test="@scheme and not(@scheme eq 'free')"> @schemeVersion can only be used if @scheme is specified.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-subtypeTyped-9">
      <rule context="tei:*[@subtype]">
         <assert test="@type"> The &lt;<name/>&gt; element should not be categorized in detail with @subtype unless also categorized in general with @type.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-calendar_attr_on_empty_element-10">
      <rule context="tei:*[@calendar]">
         <assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more systems or calendars to which the date represented by the content of this element belongs, but this &lt;<name/>&gt; element has no textual content.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-abstractModel-structure-p-in-ab-or-p-11">
      <rule context="tei:p">
         <report test="(ancestor::tei:ab or ancestor::tei:p) and                        not( ancestor::tei:floatingText                           | parent::tei:exemplum                           | parent::tei:item                           | parent::tei:note                           | parent::tei:q                           | parent::tei:quote                           | parent::tei:remarks                           | parent::tei:said                           | parent::tei:sp                           | parent::tei:stage                           | parent::tei:cell                           | parent::tei:figure )"> Abstract model violation: Paragraphs may not occur inside other paragraphs or &lt;ab&gt; elements.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-abstractModel-structure-p-in-l-12">
      <rule context="tei:l//tei:p">
         <assert test="ancestor::tei:floatingText | parent::tei:figure | parent::tei:note"> Abstract model violation: Metrical lines (&lt;l&gt; elements) may not contain higher-level structural elements such as &lt;div&gt;, &lt;p&gt;, or &lt;ab&gt;, unless &lt;p&gt; is a child of &lt;figure&gt; or &lt;note&gt;, or is a descendant of &lt;floatingText&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-deprecationInfo-only-in-deprecated-13">
      <rule context="tei:desc[ @type eq 'deprecationInfo']">
         <assert test="../@validUntil">Information about a deprecation should only be present in a specification element that is being deprecated: that is, only an element that has a @validUntil attribute should have a child &lt;desc type="deprecationInfo"&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-rt-target-not-span-14">
      <rule context="tei:rt/@target">
         <report test="../@from | ../@to">When @target is present, neither @from nor @to should be.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-rt-from-15">
      <rule context="tei:rt/@from">
         <assert test="../@to">When @from is present, the @to attribute of &lt;<name/>&gt; is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-rt-to-16">
      <rule context="tei:rt/@to">
         <assert test="../@from">When @to is present, the @from attribute of &lt;<name/>&gt; is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-ptrAtts-17">
      <rule context="tei:ptr">
         <report test="@target and @cRef">Only one of the attributes @target and @cRef may be supplied on &lt;<name/>&gt;.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-refAtts-18">
      <rule context="tei:ref">
         <report test="@target and @cRef">Only one of the attributes @target and @cRef may be supplied on &lt;<name/>&gt;.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-gloss-list-must-have-labels-19">
      <rule context="tei:list[@type='gloss']">
         <assert test="tei:label"> The content of a "gloss" list should include a sequence of one or more pairs of a &lt;label&gt; element followed by an &lt;item&gt; element.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-targetorcontent1-20">
      <rule context="tei:relatedItem">
         <report test="@target and count( child::* ) &gt; 0">If the @target attribute on <name/> is used, the relatedItem element must be empty.</report>
         <assert test="@target or child::*">A relatedItem element should have either a @target attribute or a child element to indicate the related bibliographic item.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-antilabe-part-sequence-21">
      <rule context="tei:l[@part='I']" role="warning">
         <assert test="following::tei:l[1]/@part = ('M', 'F')"> A verse line with part="I" (initial part of an antilabe) must be followed by a verse line with part="M" or part="F".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-antilabe-part-sequence-22">
      <rule context="tei:l[@part='M']" role="warning">
         <assert test="preceding::tei:l[1]/@part = ('I', 'M')"> A verse line with part="M" (medial part of an antilabe) must be preceded by a verse line with part="I" or part="M".</assert>
         <assert test="following::tei:l[1]/@part = ('M', 'F')"> A verse line with part="M" (medial part of an antilabe) must be followed by a verse line with part="M" or part="F".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-antilabe-part-sequence-23">
      <rule context="tei:l[@part='F']" role="warning">
         <assert test="preceding::tei:l[1]/@part = ('I', 'M')"> A verse line with part="F" (final part of an antilabe) must be preceded by a verse line with part="I" or part="M".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-abstractModel-structure-l-in-l-24">
      <rule context="tei:l">
         <report test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">Abstract model violation: Metrical lines (&lt;l&gt; elements) may not contain &lt;l&gt; or &lt;lg&gt; elements.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-atleast1oflggapl-25">
      <rule context="tei:lg">
         <assert test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0">An &lt;lg&gt; element must contain at least one child &lt;l&gt;, &lt;lg&gt;, or &lt;gap&gt; element.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-abstractModel-structure-lg-in-l-26">
      <rule context="tei:lg">
         <report test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">Abstract model violation: Lines may not contain line groups.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-network_sp_with_who_attr-27">
      <rule context="tei:sp" role="warning">
         <assert test="@who"> A speech 'sp' without an attribute '@who' is not used when extracting the network. SHOULD consider linking the speech act to a speaking character ('person') in the 'particDesc'.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-network_unlinked_sp-28">
      <rule context="tei:sp[@who]">
         <let name="refs" value="tokenize(normalize-space(@who), '\s+')"/>
         <assert test="every $r in $refs satisfies starts-with($r, '#')"> References in @who must start with "#".</assert>
         <let name="local-ids" value="for $r in $refs return replace($r,'#','')"/>
         <let name="valid-ids"
              value="ancestor::tei:TEI//tei:particDesc//(tei:person|tei:personGrp)[@xml:id]/@xml:id"/>
         <let name="missing" value="distinct-values($local-ids[not(. = $valid-ids)])"/>
         <assert test="empty($missing)" role="warning"> One or more @who values do not refer to valid IDs in particDesc: <value-of select="$missing"/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-play_sub_title-29">
      <rule context="tei:titleStmt[count(tei:title[not(@xml:lang or @type)]) &gt; 1]"
            role="warning">
         <assert test="tei:title[not(@xml:lang) and @type = 'sub']"> When using multiple &lt;title&gt; elements consider marking subtitles with a @type "sub".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-corpus_xml_corpus_name-30">
      <rule context="/(tei:teiCorpus|tei:dracorCorpus)/tei:teiHeader/tei:fileDesc/tei:publicationStmt"
            see="https://dracor.org/doc/odd#section-corpus-xml"
            role="critical">
         <assert test="tei:idno[not(@type) or (@type eq 'URI' and @xml:base='https://dracor.org/')]"> The corpus.xml must define the corpus name in an &lt;idno&gt; with no @type attribute, e.g. &lt;idno&gt;ger&lt;/idno&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-corpus_xml_corpus_name_syntax-31">
      <rule context="/(tei:teiCorpus|tei:dracorCorpus)/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno[not(@type) or (@type eq 'URI' and @xml:base='https://dracor.org/')]"
            see="https://dracor.org/doc/odd#section-corpus-xml"
            role="critical">
         <assert test="matches(., '^[a-z]+$')"> The corpus name must consist of lowercase ASCII characters only.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-corpus_xml_repository_url-32">
      <rule context="/(tei:teiCorpus|tei:dracorCorpus)/tei:teiHeader/tei:fileDesc/tei:publicationStmt"
            see="https://dracor.org/doc/odd#section-corpus-xml"
            role="warning">
         <assert test="tei:ref[@type eq 'repo']/@target or tei:idno[@type eq 'repo']"> The corpus.xml should specify the GitHub repository of the corpus in the @target attribute of a &lt;ref&gt; element of @type "repo".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-corpus_xml_deprecation-33">
      <rule context="/(tei:teiCorpus|tei:dracorCorpus)/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno"
            see="https://dracor.org/doc/odd#section-corpus-xml"
            role="warning">
         <report test="@type eq 'repo'"> The use of &lt;idno&gt; to specify the corpus repository is deprecated. Use a &lt;ref&gt; element with @type "repo" instead.</report>
         <report test="@type eq 'URI' and @xml:base='https://dracor.org/'"> The use of an &lt;idno&gt; with @type eq "URI" and @xml:base to specify the corpus name is deprecated. Use an &lt;idno&gt; with no attributes instead.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-idno_wikidata_qid-34">
      <rule context="tei:idno[@type eq 'wikidata']">
         <assert test="matches(normalize-space(.), '^Q[1-9]\d*$')"> The content of an &lt;idno type="wikidata"&gt; must be a Wikidata QID, e.g. "Q42", not a full URL.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-licence_target_url-35">
      <rule context="tei:licence" role="warning">
         <assert test="@target"> Consider providing the URL to the full licence text in a @target attribute.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-digital_original_source_in_sourceDesc-36">
      <rule context="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc"
            see="https://dracor.org/doc/odd#section-sources">
         <assert test="tei:bibl[@type eq 'originalSource'] or tei:bibl[@type eq 'digitalSource']/tei:bibl[@type eq 'originalSource']"> A bibliographic reference to the original source is required. Use a &lt;bibl&gt; element of @type "originalSource".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-sources_count_and_nesting-37">
      <rule context="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc[tei:bibl]"
            role="warning"
            see="https://dracor.org/doc/odd#section-sources">
         <assert test="not(tei:bibl[@type eq 'digitalSource']/tei:bibl[@type eq 'originalSource'])"> Nesting digital and original source is deprecated. The &lt;bibl&gt; elements should be siblings.</assert>
         <assert test="count(.//tei:bibl[@type eq 'digitalSource']) &lt; 2"> There is more than one digital source. The DraCor API will ignore any other than the first one.</assert>
         <assert test="count(.//tei:bibl[@type eq 'originalSource']) &lt; 2"> There is more than one original source. The DraCor API will ignore any other than the first one.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-digital_source_use_ref-38">
      <rule context="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl[@type eq 'digitalSource']"
            role="warning"
            see="https://dracor.org/doc/odd#section-sources">
         <assert test="tei:ref[@target]"> The digital source should use a &lt;ref&gt; element with a @target attribute to specify the digital source.</assert>
         <assert test="not(tei:name and tei:idno[@type eq 'URL'])"> The use of &lt;idno&gt; with @type "URL" to specify the digital source is deprecated. Use a &lt;ref&gt; element instead.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-digital_source_availability-39">
      <rule context="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl[@type eq 'digitalSource']"
            role="warning"
            see="https://dracor.org/doc/odd#section-sources">
         <assert test="tei:availability"> The digital source should provide an &lt;availability&gt; element documenting its licensing and/or copyright status.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-quotationContents-40">
      <rule context="tei:quotation">
         <report test="not( @marks )  and  not( tei:p )"> On &lt;<name/>&gt;, either the @marks attribute should be used, or a paragraph of description provided.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-citestructure-outer-match-41">
      <rule context="tei:citeStructure[not(parent::tei:citeStructure)]">
         <assert test="starts-with(@match,'/')">An XPath in @match on the outer &lt;<name/>&gt; must start with '/'.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-citestructure-inner-match-42">
      <rule context="tei:citeStructure[parent::tei:citeStructure]">
         <assert test="not(starts-with(@match,'/'))">An XPath in @match must not start with '/' except on the outer &lt;<name/>&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-xml_model_or_type_dracor_on_root_tei_element-43">
      <rule context="/tei:TEI" role="warning">
         <assert test="@type = 'dracor' or /processing-instruction('xml-model')"> The root <name/> element should have a @type="dracor" attribute if the schema is not reference in an xml-model PI.</assert>
         <assert test="not(/processing-instruction('xml-model')) or (some $pi in /processing-instruction('xml-model')                           satisfies matches($pi, 'href\s*=\s*[&#34;'']https://dracor\.org/schema\.rng[&#34;'']'))"> The DraCor schema should be refrerenced as "https://dracor.org/schema.rng" when using a xml-model PI.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-valid_dracor_ids_on_root_tei_element-44">
      <rule context="tei:TEI" role="warning">
         <assert test="matches(./@xml:id,'^[a-z]+[0-9]{6}$')"> For DraCor IDs we recommend the pattern ^[a-z]+[0-9]{6}$</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-no_empty_content_bearing_elements-45">
      <rule context="tei:title | tei:titlePart | tei:name                                  | tei:persName | tei:forename | tei:surname                                  | tei:addName | tei:genName | tei:roleName                                  | tei:author | tei:editor | tei:docAuthor                                  | tei:docTitle | tei:publisher | tei:pubPlace                                  | tei:speaker | tei:head | tei:role                                  | tei:roleDesc | tei:castItem | tei:rs                                  | tei:note | tei:keywords | tei:emph                                  | tei:foreign | tei:argument | tei:epigraph                                  | tei:dateline | tei:change | tei:edition                                  | tei:stage | tei:idno | tei:bibl"
            role="warning">
         <report test="not(normalize-space(.)) and not(*)"> Element &lt;<name/>&gt; should not be empty.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-no_empty_content_bearing_elements-46">
      <rule context="tei:ref" role="warning">
         <report test="not(normalize-space(.)) and not(*) and not(@target)"> Empty &lt;ref&gt; has no @target and no anchor text.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-no_empty_content_bearing_elements-47">
      <rule context="tei:date" role="warning">
         <report test="not(normalize-space(.)) and not(*)                                     and not(@when|@from|@to|@notBefore|@notAfter)"> Empty &lt;date&gt; should at least carry a date attribute (@when, @from, @to, @notBefore or @notAfter).</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-network_check_basic_play_structure_div-48">
      <rule context="tei:body" role="warning">
         <assert test="tei:div"> A play SHOULD at least have one structural division 'div' for the API to be able to extract a network.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-network_check_basic_play_structure_sp-49">
      <rule context="tei:body" role="warning">
         <assert test=".//tei:sp"> A play SHOULD be structured in speech-acts using the element 'sp' for the API to be able to extract a network.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-network_play_without_speaking_characters-50">
      <rule context="tei:body[not(.//tei:sp)]" role="warning">
         <assert test=".//tei:stage" role="warning"> A drama that does not contain a speech-act 'sp', SHOULD at least contain a stage direction 'stage'.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-abstractModel-structure-div-in-l-51">
      <rule context="tei:l//tei:div">
         <assert test="ancestor::tei:floatingText"> Abstract model violation: Metrical lines (&lt;l&gt; elements) may not contain higher-level structural elements such as &lt;div&gt;, unless &lt;div&gt; is a descendant of &lt;floatingText&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-abstractModel-structure-div-in-ab-or-p-52">
      <rule context="tei:div">
         <report test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)"> Abstract model violation: &lt;p&gt; and &lt;ab&gt; may not contain higher-level structural elements such as &lt;div&gt;, unless &lt;div&gt; is a descendant of &lt;floatingText&gt;.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-linkTargets3-53">
      <rule context="tei:link">
         <assert test="contains(normalize-space(@target),' ')">You must supply at least two values for @target on &lt;<name/>&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-abstractModel-structure-ab-in-l-54">
      <rule context="tei:l//tei:ab">
         <assert test="ancestor::tei:floatingText | parent::tei:figure | parent::tei:note"> Abstract model violation: Metrical lines (&lt;l&gt; elements) may not contain higher-level divisions such as &lt;p&gt; or &lt;ab&gt;, unless &lt;ab&gt; is a child of &lt;figure&gt; or &lt;note&gt;, or is a descendant of &lt;floatingText&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-joinTargets3-55">
      <rule context="tei:join">
         <assert test="contains( normalize-space( @target ),' ')"> You must supply at least two values for @target on &lt;<name/>&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-deprecate-standoff-wikidata-56">
      <rule context="tei:standOff/tei:listRelation"
            role="warning"
            see="https://dracor.org/doc/odd#section-play-wikidata">
         <report test="./tei:relation[@name eq 'wikidata']"> The use of standOff/listRelation/relation to encode the Wikidata ID is deprecated. Use a &lt;bibl type="wikidata"&gt; inside &lt;sourceDesc&gt; instead.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-deprecate-standoff-events-57">
      <rule context="tei:standOff/tei:listEvent"
            role="warning"
            see="https://dracor.org/doc/odd#section-play-meta-dates">
         <report test="./tei:event[@type = ('premiere', 'print', 'written')]"> The use of standOff/listEvent to encode the dates meta data is deprecated. Use a &lt;listEvent&gt; inside &lt;sourceDesc&gt; instead.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-person_ana_wikidata_deprecation-58">
      <rule context="tei:particDesc//tei:person[@ana]"
            see="https://dracor.org/doc/odd#section-character-concept-realizations"
            role="warning">
         <report test="matches(@ana, 'wikidata\.org/(entity|wiki)/Q\d+$')"> Using @ana for Wikidata links on &lt;person&gt; is deprecated. Use &lt;idno type="wikidata"&gt;Q…&lt;/idno&gt; instead. Apply migration 007-ana-to-idno.xsl to update.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-person_sex-59">
      <rule context="tei:person[@sex]"
            role="warning"
            see="https://dracor.org/doc/odd#section-character-sex-gender">
         <assert test="@sex = ('FEMALE', 'MALE', 'UNKNOWN')"> The values for person/@sex supported by the DraCor API are "FEMALE", "MALE" and "UNKNOWN".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-personGrp_ana_wikidata_deprecation-60">
      <rule context="tei:particDesc//tei:personGrp[@ana]"
            see="https://dracor.org/doc/odd#section-character-concept-realizations"
            role="warning">
         <report test="matches(@ana, 'wikidata\.org/(entity|wiki)/Q\d+$')"> Using @ana for Wikidata links on &lt;personGrp&gt; is deprecated. Use &lt;idno type="wikidata"&gt;Q…&lt;/idno&gt; instead. Apply migration 007-ana-to-idno.xsl to update.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-personGrp_sex-61">
      <rule context="tei:personGrp[@sex]"
            role="warning"
            see="https://dracor.org/doc/odd#section-character-sex-gender">
         <assert test="every $t in tokenize(@sex) satisfies $t = ('FEMALE', 'MALE', 'UNKNOWN')"> The values for personGrp/@sex supported by the DraCor API are "FEMALE", "MALE" and "UNKNOWN".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-ref-or-key-or-name-62">
      <rule context="tei:relation">
         <assert test="@ref or @key or @name">One of the attributes @name, @ref or @key must be supplied.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-active-mutual-63">
      <rule context="tei:relation">
         <report test="@active and @mutual">Only one of the attributes @active and @mutual may be supplied.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-active-passive-64">
      <rule context="tei:relation">
         <report test="@passive and not(@active)">the attribute @passive may be supplied only if the attribute @active is supplied.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-particdesc_person_id-65">
      <rule context="tei:particDesc/tei:listPerson/tei:person | tei:particDesc/tei:listPerson/tei:personGrp"
            role="error"
            see="https://dracor.org/doc/odd#section-characters">
         <assert test="@xml:id"> Each &lt;person&gt; or &lt;personGrp&gt; element in &lt;particDesc&gt; must provide an @xml:id attribute.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-particdesc_person_id_format-66">
      <rule context="tei:particDesc/tei:listPerson/tei:*[@xml:id]"
            role="warning"
            see="https://dracor.org/doc/odd#section-identifiers">
         <assert test="matches(@xml:id, '^[a-z]([-_a-z0-9]*[a-z0-9])?$')"> The @xml:id in &lt;particDesc&gt; should follow the DraCor rules for identifiers. See section "Identifiers" of the guidelines.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-noNestedS-67">
      <rule context="tei:s">
         <report test="tei:s">You may not nest one &lt;s&gt; element within another: use &lt;seg&gt; instead.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-target-from-68">
      <rule context="tei:span">
         <report test="@from and @target"> Only one of the attributes @target and @from may be supplied on &lt;<name/>&gt;.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-targetto-69">
      <rule context="tei:span">
         <report test="@to and @target"> Only one of the attributes @target and @to may be supplied on &lt;<name/>&gt;.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-tonotfrom-70">
      <rule context="tei:span">
         <report test="@to and not(@from)"> If @to is supplied on &lt;<name/>&gt;, @from must be supplied as well.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-tofrom-71">
      <rule context="tei:span">
         <report test="contains(normalize-space(@to),' ') or contains(normalize-space(@from),' ')"> The attributes @to and @from on &lt;<name/>&gt; may each contain only a single value.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-addSpan-requires-spanTo-72">
      <rule context="tei:addSpan">
         <assert test="@spanTo">The @spanTo attribute of &lt;<name/>&gt; is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-damageSpan-requires-spanTo-74">
      <rule context="tei:damageSpan">
         <assert test="@spanTo">The @spanTo attribute of &lt;<name/>&gt; is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-delSpan-requires-spanTo-76">
      <rule context="tei:delSpan">
         <assert test="@spanTo">The @spanTo attribute of &lt;<name/>&gt; is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-play_id-78">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_id">
         <let name="play_id" value="/tei:TEI/@xml:id/string()"/>
         <report test="/tei:TEI/@xml:id"> Supported API feature: play_id [value: <value-of select="$play_id"/>]</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-play_wikidata_id-79">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_wikidata_id">
         <let name="play_wikidata"
              value="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl[@type eq 'wikidata']/tei:idno[1]/text()"/>
         <report test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl[@type eq 'wikidata']/tei:idno[matches(normalize-space(.), '^Q[1-9]\d*$')]"> Supported API feature: play_wikidata_id [value: <value-of select="$play_wikidata"/>]</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-play_title-80">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_title">
         <let name="play_title"
              value="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[not(@type = 'sub') and not(@xml:lang or ./ancestor::tei:TEI/@xml:lang = @xml:lang)]/normalize-space()"/>
         <report test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[not(@type = 'sub') and not(@xml:lang or ./ancestor::tei:TEI/@xml:lang = @xml:lang)]"> Supported API feature: play_title [value: <value-of select="$play_title"/>]</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-play_subtitle-81">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_subtitle">
         <let name="play_subtitle"
              value="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type = 'sub' and not(@xml:lang or ./ancestor::tei:TEI/@xml:lang = @xml:lang)]/normalize-space()"/>
         <report test="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']"> Supported API feature: play_subtitle [value: <value-of select="$play_subtitle"/>]</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-play_year_written-82">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_year_written">
         <let name="play_year_written"
              value="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listEvent/tei:event[@type eq 'written']/@when/string()"/>
         <report test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listEvent/tei:event[@type eq 'written']/@when"> Supported API feature: play_year_written [value: <value-of select="$play_year_written"/>]</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-play_year_printed-83">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_year_printed">
         <let name="play_year_printed"
              value="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listEvent/tei:event[@type eq 'print']/@when/string()"/>
         <report test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listEvent/tei:event[@type eq 'print']/@when"> Supported API feature: play_year_printed [value: <value-of select="$play_year_printed"/>]</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-encoding-hint_play_wikidata_id-84">
      <rule context="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl[@type eq 'wikidata']"
            role="warning"
            see="https://dracor.org/doc/odd#section-play-wikidata">
         <assert test="./tei:idno[matches(normalize-space(.), '^Q[1-9]\d*$')]"> The Wikidata ID is expected to be wrapped in an &lt;idno&gt; element and must match the regular expression "Q[1-9]\d*".</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-character_wikidata_id-85">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#character_wikidata_id">
         <report test="//tei:particDesc//(tei:person|tei:personGrp)/tei:idno[@type eq 'wikidata'][matches(normalize-space(.), '^Q[1-9]\d*$')]"> Supported API feature: character_wikidata_id</report>
      </rule>
   </pattern>
</schema>
