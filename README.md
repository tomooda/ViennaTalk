![ViennaTalk logo](images/ViennaTalk-logo.png)

Documentation for ViennaTalk
===
ViennaTalk is a Smalltalk library to handle VDM-SL specifications.


Platform
---
ViennaTalk works on [Pharo 4.0](http://pharo.org/) .
MacOSX and Linux is supported. Windows platforms are partially supported; a local VDMJ process does not work on Widnows due to limitation of OSProcess's piping functions.

License
---
ViennaTalk is distributed under [the MIT license](https://github.com/tomooda/ViennaTalk-doc/blob/master/LICENSE).

Install
---
You may either download a pre-built package from [Release page](https://github.com/tomooda/ViennaTalk-doc/releases) or install from source code repository into [Pharo](http://pharo.org/).

Source Repository
---
The monticello repository is available at http://smalltalkhub.com/#!/~tomooda/ViennaTalk.
If you like to install from source code, please install <tt>ConfigurationOfViennaTalk</tt> and then evaluate <tt>ConfigurationOfViennaTalk load</tt>.
Or, you may at once install it by evaluating 

```
Gofer new smalltalkhubUser: 'tomooda' project: 'ViennaTalk';
    configurationOf: #ViennaTalk; load. 
(Smalltalk at: #ConfigurationOfViennaTalk) load
```

How to use
---
The ViennaTalk Launcher provides quick access.

![ViennaLauncher](images/ViennaLauncher.png)

The tools menu provies shortcuts to the tools, such as VDM Browser, Lively Walk-Through and so on.

![ViennaLauncher tools menu](images/ViennaLauncher-menu.png)

The *ViennaTalk* menu will be available in the World menu.

![World->Tools menu items for ViennaTalk](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/ViennaTalk-menu.png)

Settings
---
You can open the Settings dialog from either Tools>>settings... menu of ViennaLauncher or System>>Settings menu of the World menu.

![settings menu of ViennaLauncher](images/SettingsMenu.png)

Then the Settings Browser opens.

![SettingsBrowser](images/SettingsBrowser.png)

If you want to setup the font for VDM sources, you can click on the font to open a font chooser dialog.

![FontChooser dialog](images/SettingsFont.png)

The update button will read all available fonts in the system. You can then choose the font family and point size, and press OK.

Table of Major Components of ViennaTalk
---

* [VDMBrowser](VDMBrowser.md)
* [VDMPad](VDMPad.md)
* VDMC
* [Lively Walk-Through](LivelyWalk-Through.md)
* [Webly Walk-Through](WeblyWalkThrough.md)
* ViennaEngine
   - ViennaVDMJ
   - ViennaServer
   - ViennaClient
   - ViennaBankEngine



Acknowledgement
---
Part of the ViennaTalk project is supported by Grant-in-Aid for Scientific Research (S) 24220001 from the Japan Society for the Promotion of Science.
