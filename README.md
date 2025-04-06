[![Pharo version](https://img.shields.io/badge/Pharo-12-87CEFA.svg)](https://pharo.org/download)
[![CI](https://github.com/tomooda/ViennaTalk/actions/workflows/test.yml/badge.svg)](https://github.com/tomooda/ViennaTalk/actions/workflows/test.yml)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cormas/cormas/master/LICENSE)

![ViennaTalk logo](https://viennatalk.org/images/ViennaTalk-logo.png)

ViennaTalk ~ Live and Formal
===
ViennaTalk is a Smalltalk library to handle VDM-SL specifications.

Downloads
---

The latest release: [<kbd> <br> Milan <br> &nbsp; </kbd>](https://github.com/tomooda/ViennaTalk/releases/latest/)
   * macOS / AppleSilicon [![download](https://img.shields.io/badge/DOWNLOAD-f0f0f0?labelColor=a0a0a0&style=flat&logoColor=white&logo=DocuSign)](https://viennatalk.org/builds/viennatalk/latest/ViennaTalk-Installer-Darwin-arm64.dmg)
   * macOS / Intel processor [![download](https://img.shields.io/badge/DOWNLOAD-f0f0f0?labelColor=a0a0a0&style=flat&logoColor=white&logo=DocuSign)](https://viennatalk.org/builds/viennatalk/latest/ViennaTalk-Installer-Darwin-x86_64.dmg)
   * windows64 / Intel processor [![download](https://img.shields.io/badge/DOWNLOAD-f0f0f0?labelColor=a0a0a0&style=flat&logoColor=white&logo=DocuSign)](https://viennatalk.org/builds/viennatalk/latest/ViennaTalk-Windows-x86_64.zip)

Documentation
---
Documentation is available at [ViennaTalk.org](http://viennatalk.org/).

Public VDMPad server
---
You can freely try VDMPad without any registration at [Public VDMPad server](http://vdmpad.viennatalk.org).


Platform
---
ViennaTalk works on [Pharo 12](http://pharo.org/) .
MacOSX and Linux is supported. Windows platforms are partially supported; a local VDMJ process does not work on Widnows due to limitation of OSSubprocess's piping functions.

License
---
ViennaTalk is distributed under [the MIT license](https://github.com/tomooda/ViennaTalk-doc/blob/master/LICENSE).

Install
---
You may either download a pre-built package from [Release page](https://github.com/tomooda/ViennaTalk-doc/releases), install viennatalk+pharo from command shell, or install from source code repository into [Pharo](http://pharo.org/).

Source Repository
---
The source code repository is available at https://github.com/tomooda/ViennaTalk.

On macOS or Linux, you may download Pharo and installl ViennaTalk using the following command on a shell

```
curl https://raw.githubusercontent.com/tomooda/ViennaTalk/main/scripts/install-viennatalk.sh | bash
```


If you like to install ViennaTalk on an existing Pharo installation, please use Iceberg to clone https://github.com/tomooda/ViennaTalk.git with <tt>repository</tt> subdirectory, and load <tt>BaselineOfViennaTalk</tt> and install its baseline.
Or, you may programmatically install it by evaluating 

```
EpMonitor disableDuring: [
	Metacello new
		onConflictUseLoaded;
		onWarningLog;
		repository: 'github://tomooda/ViennaTalk:main/';
		baseline: 'ViennaTalk';
		load ] 
```

Acknowledgements
---
Part of the ViennaTalk project is supported by Grant-in-Aid for Scientific Research (S) 24220001, Grant-in-Aid for Scientific Research (C) 26330099, and Grant-in-Aid for Early-Career Scientists 18K18033 from the Japan Society for the Promotion of Science.

The ViennaTalk project is supported by [Software Research Associates, Inc.](https://www.sra.co.jp/en/).

[![SRA logo](resources/SRA-logo-large.png)](https://www.sra.co.jp/en/)
