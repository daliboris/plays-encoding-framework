xquery version "3.1" encoding "utf-8";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare variable $csv external := true();

declare function local:find-hierarchy ($bibls as node()*) as node()* {
 for $bibl in $bibls
  let $author := $bibl/tei:author
   group by $author
  order by $author
  return
   
  <author name="{$author}">{
  for $bib in $bibl
  let $title := $bib/tei:title
   group by $title
  order by $title
  return
  <title name="{$title}">
   {for $bi in $bib
    order by $bi/tei:biblScope
    return <scope>{ $bi/tei:biblScope/data()}</scope>
   }
  </title>
  }</author>
};

declare function local:find-csv ($bibls as node()*) as node()*
{ 
 for $bibl in $bibls
  let $author := $bibl/tei:author
   group by $author
  order by $author
  return
  
  for $bib in $bibl
  let $title := $bib/tei:title
   group by $title
  order by $title
  return
  
   for $bi in $bib
    order by $bi/tei:biblScope
    return (<item><author>{$author}</author><title>{$title}</title><scope>{ $bi/tei:biblScope/data()}</scope></item>)
   
};

declare function local:find ($bibls as node()*) as node()*
{ 
  if($csv) then local:find-csv($bibls) else local:find-hierarchy($bibls)
};

let $play := /tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title
let $bibls := //tei:app[not(tei:lem)]/tei:note//tei:bibl
let $bibliography := local:find($bibls)
return <result play="{$play}">{$bibliography}</result>