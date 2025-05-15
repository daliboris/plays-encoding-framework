xquery version "3.1" encoding "utf-8";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare default collation "http://www.w3.org/2013/collation/UCA?lang=cs-CZ";

(:import module namespace xds="https://www.daliboris.cz/ns/xquery/drama/speaker" at "speaker-names-helper.xqm"; :)
declare namespace xds="https://www.daliboris.cz/ns/xquery/drama/speaker"; 


declare function xds:clean-name($name as xs:string?) as xs:string? 
{
 let $result := translate( normalize-space($name) , "[]:", "")
 let $result := replace($result, "Gen\.", "Genius")
 let $result := replace($result, "men\.", "mendicorum")
 let $result := replace($result, "žebr\.", "žebráků")
 let $result := if (contains($result, " omnes")) then () else $result
 return $result
};

 declare function xds:get-valid-id ($item as xs:string?) as xs:string 
{
 translate($item,  " ,.:", "---") => replace("--", "-") => lower-case()
};

declare function xds:get-valid-xml-id ($item as xs:string?, $play-name-suffix as xs:string?) as xs:string 
{
 let $suffix := if(empty($play-name-suffix)) then "" else "-" || $play-name-suffix
 return "per." || xds:get-valid-id($item) || $suffix
};

declare function xds:get-tei-particDesc ($items as element(speaker)*, $play-name as xs:string?) as element(tei:particDesc) 
{
<tei:particDesc>
 <tei:listPerson>
 <tei:head xml:lang="cs">Seznam postav</tei:head>
 <tei:head xml:lang="en">List of characters</tei:head>
  {for $item in $items 
   return xds:get-person-tei($item, $play-name)
    }
 </tei:listPerson>
</tei:particDesc>
};

declare function xds:get-person-tei ($item as element(speaker), $play-name as xs:string?) as element(tei:person)  {
 let $occupation := if(empty($play-name))
  then "Postava vystupující v této hře" 
  else "Postava vystupující ve hře " || $play-name
 let $id := $item/@id
 return <tei:person xml:id="{$id}" sex="MALE">
  {
  for $i in $item/variant
  let $invariant := $i/@invariant
  let $lang := $i/@xml:lang
  group by $lang, $invariant
  order by $lang descending
  return
   <tei:persName xml:lang="{$lang}" type="main">{$invariant}</tei:persName>
   }
   <tei:note type="bio"/>
   <tei:occupation>{$occupation}</tei:occupation>
   </tei:person>
};



declare variable $include-variants as xs:boolean external := true(); 

declare function local:get-invariant ( $name as xs:string?) as element(item)? 
{
  let $clean := xds:clean-name($name)
 
  return <item>{
  if ($clean != $name) then
  (
   attribute {"invariant"} {$clean},
   attribute {"var"} {$name}
  )
 else if (matches($name, "(\w+)\s+(\d+)")) then
  (
  attribute {"invariant"} {substring-before($name, " ")},
  attribute {"var"} {substring-after($name, " ")}
  )
  else
  attribute {"invariant"} {$name} 
 }
 {$name}
 </item>
 }; 

declare function local:get-output ($names as xs:string*, $function as function(*)) 
{ 
 $function($names)
};

declare function local:get-output-string ($items as xs:string*) as xs:string*
{ 
for $item in $items
 return concat($item, "&#xa;")
};

declare function local:get-output-tei ($items as xs:string*) as element(tei:particDesc) 
{
<tei:particDesc>
 <tei:listPerson>
  {for $item in $items 
   let $id := xds:get-valid-xml-id($item, ())
   return <tei:person xml:id="{$id}">
   <tei:persName>{$item}</tei:persName>
   </tei:person> }
 </tei:listPerson>
</tei:particDesc>
};

declare function local:get-names-only($items as element(tei:speaker)*) as element(tei:particDesc)
{ 
  let $names := for $item in $items
   return xds:clean-name($item)


  let $names := for $name in distinct-values($names)
   order by $name
   return $name
  
  let $names := local:get-output($names, local:get-output-tei#1)
  
  return $names
 };
 
 declare function local:get-names-with-variants($items as element(tei:speaker)*, $lang as xs:string) as element(tei:particDesc) {
 
 let $names := for $item in distinct-values($items)
     order by $item
     return $item

 let $names := for $name in $names
  return local:get-invariant($name)
 
 let $names := for $name in $names
 let $invariant := $name/@invariant
 group by $invariant
 order by $invariant
 return
  let $variants := for $i in $name return <tei:persName type="variant">{data($i/@var)}</tei:persName>
  let $id := "per." || $lang || "." || xds:get-valid-id($invariant)
  return <tei:person xml:id="{$id}">
   <tei:persName xml:lang="{$lang}">{$invariant}</tei:persName> 
   {$variants}
  </tei:person>
  
  return
  <tei:particDesc>
   <tei:listPerson>
    {$names}
   </tei:listPerson>
  </tei:particDesc>
 };
 
 
 let $lang := /tei:TEI/@xml:lang
 let $items := /tei:TEI/tei:text//tei:speaker
(:let $items := tei:teiCorpus/tei:TEI[2]/tei:text//tei:speaker:)

let $names := if($include-variants) then
 local:get-names-with-variants($items, $lang)
 else
 local:get-names-only($items)



(: let $names := local:get-output($names, local:get-output-string#1) :)

return $names