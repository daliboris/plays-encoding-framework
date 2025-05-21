# Plays Encoding Framework

Plays Encoding Framework for conversion and encoding plays in TEI format

## Prerequisites

- [Java 11](https://www.azul.com/downloads/?version=java-11-lts&package=jdk#zulu "Download Azul Zulu OpenJDK")
- [Saxon-HE 12.3](https://github.com/Saxonica/Saxon-HE/releases/tag/SaxonHE12-7 "Download SaxonHE12-7J")
- [MorganaXProc-IIIse 1.6.7](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.6.7/ "Donwload MorganaXProc-IIIse 1.6.7")

### Setting up the environment

- [ ] Install Java JDK 11
- [ ] Extract content of the [MorganaXProc-IIIse-1.6.7.zip](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.6.7/MorganaXProc-IIIse-1.6.7.zip/download "Donwload MorganaXProc-IIIse 1.6.7.zip file")
- [ ] Extract content of the [SaxonHE12-5J.zip](https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-7/SaxonHE12-7J.zip "Download SaxonHE12-7J") file
  - [ ] copy extracted `saxon-he-12.7.jar` and `saxon-he-xqj-12.7.jar` files to the `MorganaXProc-IIIse_lib` folder
- [ ] On your operating system, set environment `PATH` variable to point to the location of the `MorganaXProc-IIIse` folder
- for example on Windows:
  - (run command line as usual user): `setx PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`
  - (run command line as administrator): `setx /m PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`
    - [switch](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/setx) `/m`: Specifies to set the variable in the system environment. The default setting is the local environment.

### Runnig pipeline

Use pipelines stored in the [`run`](./run) directory in file with `.xpl` extension.

You can modify options. Frequently used options and their meaning:

- `debug-path`: directory used for storing temporary files (for debugging)
- `data-file-path`: file with metadata for file to be converted; data files are usualy stored in the [`data`](./data) directory
- `output-directory-path`: directory used for storing result files
- `output-file-name`: the name of the file stored in the output directory, withou extension

If use directory names `_debug`, `_output` or `_temp`, they will not be synchronized with the GitHub repository.

### Available pipelines

#### hub2tei.xpl

Converts plays in [hub format](https://transpect.github.io) to XML according to [TEI](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html) and [DraCor](https://dracor.org/doc/odd) standards, and for [EVT Viewer](http://evt.labcd.unipi.it).

#### docx2tei.xpl

Converts critical editions in DOCX documents to XML according to the [TEI](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html) and [DraCor](https://dracor.org/doc/odd) standards, and for [EVT Viewer](http://evt.labcd.unipi.it).

#### docx2dracor.xpl

Converts editions in DOCX documents to XML according to the [DraCor](https://dracor.org/doc/odd) standard.

#### setup.xpl

Downloads and updates resources for the conversion and validation, like MorganaXProc-IIIse runtime, Saxon-HE libraries and RNG or XML schemas. 