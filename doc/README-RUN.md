# XProc Analysis Report

## docx2dracor.xpl
#### **default** (docx2dracor)
#### Documentation (0)
    
##### 

#### Namespaces (13)
    
| prefix | string |
| --- | --- |
| c | http://www.w3.org/ns/xproc-step |
| dxfs | https://www.daliboris.cz/ns/xproc/file-system |
| fs | https://www.daliboris.cz/ns/file-system |
| p | http://www.w3.org/ns/xproc |
| xd2dc | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpefjt | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/job-ticket |
| xpl | https://www.daliboris.cz/ns/xproc/pipeline |
| xs | http://www.w3.org/2001/XMLSchema |
| xtei | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (3)
    
- ../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl
- ../src/xproc/docx2dracor-lib.xpl
- ../src/xproc/tei-play-lib.xpl

#### Options (7)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = '../_debug' \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-directory-path | name = data-directory-path \| as = xs:anyURI \| select = '../data' |
| data-file-path | name = data-file-path \| as = xs:string \| select = '../data/local.gnapheus-acolastus-data.xml' |
| innput-directory-path | name = innput-directory-path \| select = '../src/input/text/docx/dracor' \| as = xs:string? |
| output-directory-path | name = output-directory-path \| as = xs:string? \| select = '../_output' |
| output-file-name | name = output-file-name \| as = xs:string? \| select = () |

#### Ports (3)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | job-ticket | false |
| output | **result** | true |

### Steps  (0 + 18)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | steps |   |   | 
|   |   |   | pipe | job-ticket@docx2dracor | 
|   |   |   | select | /xpefjt:job-ticket/xpefjt:scenario/xpefjt:step | 
| 4 | dxfs:document-file-info | info |   |   | 
| 5 | p:variable | file-stem |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file/@stem | 
| 6 | p:variable | output-file-name |   |   | 
|   |   |   | select | if(empty($output-file-name)) then $file-stem else $output-file-name | 
| 7 | p:variable | text-id |   |   | 
|   |   |   | href | {$data-file-path} | 
|   |   |   | select | /data/@id | 
| 8 | p:variable | source-debug-path |   |   | 
|   |   |   | select | if(empty($debug-path)) then () else $debug-path \|\|  '/' \|\| $text-id | 
| 9 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $steps[@name='xd2dc:input-processing'] | 
| 10 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $steps[@name='xd2dc:tei-processing'] | 
| 11 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $steps[@name='xd2dc:tei-postprocessing'] | 
| 12 | p:identity | tei |   |   | 
| 13 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$text-id}/tei | 
| 14 | xtei:convert |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path} | 
|   |   |   | output-file-name | {$output-file-name} | 
|   |   |   | pipe | result@tei | 
|   |   |   | target | text | 
| 15 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}-tei.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$text-id}/text | 
| 16 | xd2dc:convert |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | pipe | source@docx2dracor | 
|   |   |   | target | text | 
| 17 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}-docx.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$text-id}/text | 
| 18 | p:identity |  |   |   | 
|   |   |   | pipe | report | 


## docx2tei.xpl
#### **default** (docx2tei)
#### Documentation (0)
    
##### 

#### Namespaces (11)
    
| prefix | string |
| --- | --- |
| c | http://www.w3.org/ns/xproc-step |
| p | http://www.w3.org/ns/xproc |
| xd2t | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpefjt | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/job-ticket |
| xpl | https://www.daliboris.cz/ns/xproc/pipeline |
| xs | http://www.w3.org/2001/XMLSchema |
| xtei | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (4)
    
- ../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl
- ../src/xproc/docx2tei-lib.xpl
- ../src/xproc/rochotius/docx2tei-rochotius-lib.xpl
- ../src/xproc/tei-play-lib.xpl

#### Options (6)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = '../_debug' \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-directory-path | name = data-directory-path \| as = xs:anyURI \| select = '../data' |
| data-file-path | name = data-file-path \| as = xs:string \| select = '../data/local.rochotius-comoedia-data.xml' |
| output-directory-path | name = output-directory-path \| as = xs:string? \| select = '../_output' |
| output-file-name | name = output-file-name \| as = xs:string? \| select = 'rochotius-comoedia' |

#### Ports (3)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | job-ticket | false |
| output | **result** | true |

### Steps  (0 + 18)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | steps |   |   | 
|   |   |   | pipe | job-ticket@docx2tei | 
|   |   |   | select | /xpefjt:job-ticket/xpefjt:scenario/xpefjt:step | 
| 4 | p:variable | text-id |   |   | 
|   |   |   | href | {$data-file-path} | 
|   |   |   | select | /data/@id | 
| 5 | p:variable | source-debug-path |   |   | 
|   |   |   | select | if(empty($debug-path)) then () else $debug-path \|\|  '/' \|\| $text-id | 
| 6 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $steps[@name='xd2t:input-processing'] | 
| 7 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $steps[@name='xd2t:input-processing-rochotius'] | 
| 8 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $steps[@name='xd2t:tei-postprocessing-rochotius'] | 
| 9 | p:identity | tei |   |   | 
| 10 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$text-id}/tei | 
| 11 | xtei:convert |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path} | 
|   |   |   | output-file-name | {$output-file-name} | 
|   |   |   | pipe | result@tei | 
|   |   |   | target | DraCor | 
| 12 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$text-id}/dracor | 
| 13 | xtei:convert |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path} | 
|   |   |   | output-file-name | {$output-file-name} | 
|   |   |   | pipe | result@tei | 
|   |   |   | target | text | 
| 14 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}-tei.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$text-id}/text | 
| 15 | xd2t:convert |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | pipe | source@docx2tei | 
|   |   |   | target | text | 
| 16 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}-docx.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$text-id}/text | 
| 17 | xd2t:tei-conversion | tei |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | p:use-when | false() | 
| 18 | p:identity |  |   |   | 
|   |   |   | pipe | report | 


## docx2text.xpl
#### **default**
#### Documentation (0)
    
##### 

#### Namespaces (7)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xd2t | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (2)
    
- ../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl
- ../src/xproc/docx2tei-lib.xpl

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = '../_debug' \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory-path | name = output-directory-path \| as = xs:string? \| select = '../_output' |
| output-file-name | name = output-file-name \| as = xs:string? \| select = 'rochotius-comoedia' |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | xd2t:convert |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | target | text | 
| 4 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | true | 
|   |   |   | file-name | {$output-file-name}-docx.xml | 
|   |   |   | output-directory | {$output-directory-path}/{$output-file-name}/text | 


## hub2tei.xpl
#### **default**
#### Documentation (0)
    
##### 

#### Namespaces (9)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xh2t | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/hub2tei |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpl | https://www.daliboris.cz/ns/xproc/pipeline |
| xs | http://www.w3.org/2001/XMLSchema |
| xtei | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (3)
    
- ../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl
- ../src/xproc/pef-xpc-lib-base.xpl
- ../src/xproc/hub2tei-lib.xpl

#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = '../_debug' \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? \| select = '../data/local.angelus-02-data.xml' |
| output-directory-path | name = output-directory-path \| as = xs:string? \| select = '../output' |
| output-file-name | name = output-file-name \| as = xs:string? \| select = 'angelus' |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (1 + 4)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | xh2t:process |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path} | 
|   |   |   | output-file-name | {$output-file-name} | 
| 4 | p:identity |  |   |   | 
|   |   |   | select | base-uri(/) | 

#### **xh2t:process**
#### Documentation (0)
    
##### 

#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |
| output-directory-path | name = output-directory-path \| as = xs:string? |
| output-file-name | name = output-file-name \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 5)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | xh2t:input-processing |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
| 4 | xh2t:tei-conversion |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
| 5 | xtei:postprocessing |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path} | 
|   |   |   | output-file-name | {$output-file-name} | 



