[![Pharo version](https://img.shields.io/badge/Pharo-11-87CEFA.svg)](https://pharo.org/download)
![CI](https://github.com/tomooda/ViennaTalk/actions/workflows/test.yml/badge.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cormas/cormas/master/LICENSE)

![ViennaTalk logo](images/ViennaTalk-logo.png)

ViennaTalk is a Smalltalk library to handle VDM-SL specifications.

Try [Open VDMPad server](https://vdmpad.viennatalk.org) to experience VDM-SL. No registration/no installation is required.

[VDM cheatsheet](https://viennatalk.org/ViennaDoc/cheatsheet-en/) provides major VDM-SL constructs with evaluatable examples. ([🇬🇧English version](https://viennatalk.org/ViennaDoc/cheatsheet-en/) [🇯🇵 Japanese version](https://viennatalk.org/ViennaDoc/cheatsheet-ja/))

Demo movies
---
[![Introduction to VDM Browser](https://img.youtube.com/vi/ZIR3fFPeTz0/1.jpg)](https://www.youtube.com/watch?v=ZIR3fFPeTz0)
[![ViennaTalk: Types, Values and Objects](https://img.youtube.com/vi/anZoWeA5vd0/1.jpg)](https://www.youtube.com/watch?v=anZoWeA5vd0)
[![ViennaTalk: Code Generation](https://img.youtube.com/vi/sDXiM5yvTxw/1.jpg)](https://www.youtube.com/watch?v=sDXiM5yvTxw)
[![ViennaTalk: ViennaVisuals](https://img.youtube.com/vi/utaX8UYQjRs/1.jpg)](https://www.youtube.com/watch?v=utaX8UYQjRs)

Table of Major Components of ViennaTalk
---

* [VDMBrowser](VDMBrowser.md) - A VDM-SL browser inspired by Smalltalk's class browsers and inspectors
* [VDMPad](VDMPad.md) - A lightweight web IDE for VDM-SL with animation and diagram presentation of data
* ViennaAnimation - Animation manager that encapsulate execution engine
* [Lively Walk-Through](LivelyWalk-Through.md) - A UI prototyping environment to animate UI prototype by VDM-SL specification
* [Webly Walk-Through](WeblyWalkThrough.md) - A Web API server to publish VDM-SL specifications of web APIs.
* ViennaEngine - Animation engine wrapper
   - ViennaVDMJ - Animation engine by local VDMJ process
   - ViennaServer - Web server to publish animation engines
   - ViennaClient - Client module of ViennaServer/VDMPad
   - ViennaBankEngine - Aggregated animation engine
* [ViennaTalk-Types](ViennaTalk-Types.md) - Smalltalk classes for VDM types
* [ViennaTalk-Values](ViennaTalk-Values.md) - Smalltalk objects for VDM values
* [ViennaTalk-Parsers](ViennaTalk-Parser.md) - VDM parsers, Smalltalk code generators and VDM source formatter.

What's new in the latest release
---

* Codename Lyon has been released. (Apr 30, 2024)
   - Specification slicing for VDM-SL
   - New UI design for Refactoring Browser
      - Playground with state variables table
      - EpiLog to journal and version specification changes and evaluations
   - ranspiler can be used as an alternative interpreter.
   - Support traces definitions
   - Migration to Pharo 12

* [Past Releases](Releases.md)

How to use
---
The ViennaTalk Launcher provides quick access.

![ViennaLauncher](images/ViennaLauncher.png)

The tools menu provies shortcuts to the tools, such as VDM Browser, Lively Walk-Through and so on.

![ViennaLauncher tools menu](images/ViennaLauncher-menu.png)

The *ViennaTalk* menu will be available in the World menu.

![World->Tools menu items for ViennaTalk](images/ViennaTalk-menu.png)

Settings
---
You can open the Settings dialog from either Tools>>settings... menu of ViennaLauncher or System>>Settings menu of the World menu.

![settings menu of ViennaLauncher](images/SettingsMenu.png)

Then the Settings Browser opens.

![SettingsBrowser](images/SettingsBrowser.png)

If you want to setup the font for VDM sources, you can click on the font to open a font chooser dialog.

![FontChooser dialog](images/SettingsFont.png)

The update button will read all available fonts in the system. You can then choose the font family and point size, and press OK.

Acknowledgements
---
Part of the ViennaTalk project is supported by Grant-in-Aid for Scientific Research (S) 24220001 and Grant-in-Aid for Early-Career Scientists 18K18033 from the Japan Society for the Promotion of Science.

The ViennaTalk project is supported by [Software Research Associates, Inc.](https://www.sra.co.jp/en/).

[![SRA logo](images/SRA-logo-large.png)](https://www.sra.co.jp/en/)
