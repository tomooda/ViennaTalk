VDM Browser
===

[![Introduction to VDM Browser](https://img.youtube.com/vi/ZIR3fFPeTz0/1.jpg)](https://www.youtube.com/watch?v=ZIR3fFPeTz0)

VDM Browser is a browser for VDM-SL specifications that incorporates a flavor of Smalltalk's live environment.

You can open a VDM Browser by selecting <tt>VDMBrowser</tt> in the World -> Tools menu, or simply evaluate <tt>VDMBrowser open</tt>.
You can open multiple VDM Browsers that works independent each other.

![Screenshot of VDMBrowser](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMBrowser-vanilla.png)

Loading and Saving a specification
---
The upper left pane is a list of modules in the specification. In the case of <em>flat</em> specification or an empty specification, <tt>DEFAULT</tt> is used as the module name for the entire specification.

You can load and save specifications using the context menu of the module list.

![modules menu](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMBrowser-modules-menu.png)

By selecting a module in the list, its source specification will appear in the specification pane (the lower part of the browser).

Writing a specification
---
The lower part of the VDM Browser is the specification pane where you edit the source specification of modules.
If a module is selected in the module list, the source specification of the selected module will be on the specification pane.
You can edit it and save it by the "accept" in the context menu or strike the cmd-s shortcut.
If the specification contains errors, the error message from the VDM interpreter will be inserted and selected into the specification pane.

You can also evaluate an VDM expression in the specification pane.
First, you select an expression in the specification pane to evaluate.
There are two kinds of evaluation: the "Do it" (cmd-d) or "Print it" (cmd-p).
The "Do it" only evaluate the selected expression, while the "Print it" inserts and select the resulting value into the value pane.

One typical use of this function is to check the actual value of a constant defined in the <tt>values</tt> section of the specification.
You first save the specification, then select the constant name in the specification, and dispatch "Print it" to see its actual value.
It's also a good habit to write a series of expressions in a comment and evaluate them in order to walk-through a scenario.

You can write one or more modules in the specification pane.
All modules in the specification pane will be merged into the source specification.

To remove a module, you can select "remove module" in the context menu of the module list.

Playing with states
---
The upper middle is a list of state variables in the selected module.
If no module is selected, all state variables in the specification will be listed.

![SAFER specification loaded](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMBrowser-SAFER-loaded.png)

The above shows the screenshot of VDM Browser loaded the [SAFER](http://overturetool.org/download/examples/VDMSL/SAFERSL/index.html) specification.

The upper right is a value pane where the value of the selected field (shown in below).
If no field is selected, the binding is shown in a syntax similar to the mapping in VDM-SL as shown in the above.

![field selected](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMBrowser-SAFER-state.png)

The value pane as three functions.

* to show the current values of state variables
* to modify the current values of state variables.
* to evaluate an expression in the context of the selected module.

You can edit the value (or binding) and save it by the "accept" menu or cmd-s (ctrl-s in Windows).
You can modify multiple variables at once by unselecting the field list (may also the module list) and edit the mapping.

You can also evaluate a VDM expression in the value pane.

Using Workspace
---
The VDM Browser provides a small text editor called Workspace.
You may bring Workspace in front by clicking the "Workspace" tab.

![Workspace](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMBrowser-SAFER-eval.png)

A workspace is dedicated to noting and evaluating VDM expressions.
Please note that the content of the workspace will NOT be saved into files.
If you want to keep the content of Workspace, please paste it into the specification as a comment.
