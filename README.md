# ViennaTalk-doc
Documentation for ViennaTalk, a Smalltalk library to handle VDM-SL specifications

Platform
---
ViennaTalk works on [Pharo 4.0](http://pharo.org/) .
MacOSX and Linux is supported. Windows platforms are partially supported; a local VDMJ process does not work on Widnows due to limitation of piping feature of OSProcess.

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
Please see wiki page.
