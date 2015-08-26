# ViennaTalk-doc
Documentation for ViennaTalk
---

ViennaTalk is a Smalltalk library to handle VDM-SL specifications.


Platform
---
ViennaTalk works on [Pharo 4.0](http://pharo.org/) .
MacOSX and Linux is supported. Windows platforms are partially supported; a local VDMJ process does not work on Widnows due to limitation of OSProcess'es piping functions.

License
---
ViennaTalk is distributed under [the MIT license](https://github.com/tomooda/ViennaTalk-doc/blob/master/LICENSE).

Repository
---
The monticello repository is available at http://smalltalkhub.com/#!/~tomooda/ViennaTalk.
Please install <tt>ConfigurationOfViennaTalk</tt> and then evaluate <tt>ConfigurationOfViennaTalk load</tt>.
Or, you may at once install it by evaluating 

```
Gofer new smalltalkhubUser: 'tomooda' project: 'ViennaTalk';
    configurationOf: #ViennaTalk; load. 
(Smalltalk at: #ConfigurationOfViennaTalk) load
```

How to use
---
Please see [wiki page](https://github.com/tomooda/ViennaTalk-doc/wiki).

Acknowledgement
---
Part of the ViennaTalk project is supported by Grant-in-Aid for Scientific Research (S) 24220001 from the Japan Society for the Promotion of Science.
