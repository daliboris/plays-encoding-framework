# Plays Encoding Framework

Plays Encoding Framework for conversion and encoding plays in TEI format

## Prerequisites

- [Java 11](https://www.azul.com/downloads/?version=java-11-lts&package=jdk#zulu "Download Azul Zulu OpenJDK")
- [Saxon-HE 12.3](https://github.com/Saxonica/Saxon-HE/releases/tag/SaxonHE12-3 "Download SaxonHE12-3J")
- [MorganaXProc-IIIse 1.5](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.5/ "Donwload MorganaXProc-IIIse 1.5")

### Setting up the environment

- [ ] Install Java JDK 11
- [ ] Extract content of the [MorganaXProc-IIIse-1.5.zip](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.5/MorganaXProc-IIIse-1.5.zip/download "Donwload MorganaXProc-IIIse 1.5.zip file")
- [ ] Extract content of the [SaxonHE12-5J.zip](https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-5/SaxonHE12-5J.zip "Download SaxonHE12-5J") file
  - [ ] copy extracted `saxon-he-12.5.jar` and `saxon-he-xqj-12.5.jar` files to the `MorganaXProc-IIIse_lib` folder
- [ ] On your operating system, set environment PATH variable to point to the location of the `MorganaXProc-IIIse` folder
- for example on Windows:
  - (run command line as administrator): `setx /m PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`
  - (run command line as usual user): `setx PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`
