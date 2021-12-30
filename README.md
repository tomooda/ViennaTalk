[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)
[![CI](https://github.com/tomooda/ViennaTalk/actions/workflows/test.yml/badge.svg)](https://github.com/tomooda/ViennaTalk/actions/workflows/test.yml)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cormas/cormas/master/LICENSE)

![ViennaTalk logo](https://viennatalk.org/images/ViennaTalk-logo.png)

ViennaTalk ~ Live and Formal
===
ViennaTalk is a Smalltalk library to handle VDM-SL specifications.

Documentation
---
Documentation is available at [ViennaTalk.org](http://viennatalk.org/).

Public VDMPad server
---
You can freely try VDMPad without any registration at [Public VDMPad server](http://vdmpad.viennatalk.org).


Platform
---
ViennaTalk works on [Pharo 8](http://pharo.org/) .
MacOSX and Linux is supported. Windows platforms are partially supported; a local VDMJ process does not work on Widnows due to limitation of OSSubprocess's piping functions.

License
---
ViennaTalk is distributed under [the MIT license](https://github.com/tomooda/ViennaTalk-doc/blob/master/LICENSE).

Install
---
You may either download a pre-built package from [Release page](https://github.com/tomooda/ViennaTalk-doc/releases) or install from source code repository into [Pharo](http://pharo.org/).

Source Repository
---
The source code repository is available at https://github.com/tomooda/ViennaTalk.
If you like to install from source code, please use Iceberg to clone https://github.com/tomooda/ViennaTalk.git with <tt>repository</tt> subdirectory, and load <tt>BaselineOfViennaTalk</tt> and install its baseline.
Or, you may at once install it by evaluating 

```
Metacello new
	baseline: 'ViennaTalk';
	repository: 'github://tomooda/ViennaTalk/repository';
	load.
```

Acknowledgement
---
Part of the ViennaTalk project is supported by Grant-in-Aid for Scientific Research (S) 24220001 from the Japan Society for the Promotion of Science.
