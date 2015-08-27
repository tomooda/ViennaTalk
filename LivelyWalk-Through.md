Lively Walk-Through
===
Lively Walk-Through is a GUI prototyping environment where UI designers and VDM engineers collaborate to integrate UI design and functional design.

![Screenshot of Lively Walk-Through](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-vanilla.png)

Placing widgets
---
Let's build a simple calculator which computes the total price from unit price and amount.

First, you build a prototypical GUI for it.
The left side is Workbench where you build a GUI, and the right is a list of widgets.
You can drag and drop a field widget into Workbench.

![One field is placed in Workbench](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-field1.png)

Then, You rename the widget by selecting <tt>name-&gt;change name</tt> in the context menu of the field widget.

![change name menu](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-field2.png)

You type a new name. For example, <tt>UnitPrice</tt>.

![change name menu](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-field3.png)

The field widget is now named <tt>UnitPrice</tt>.

![change name menu](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-field4.png)

Repeat this operation to build the GUI.

![all widgets placed](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-GUI1.png)

Once you are satisfied with the prototypical GUI, fix position of the widgets by selecting <tt>fix position</tt> in the context menu.

Writing a VDM specification
---
Then, you give the functional specification to the prototype.

The <tt>VDM</tt> tab on the top right will bring the VDM Browser in front. 

![VDM Browser](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-VDM1.png)

Please read (the VDM Browser section)[https://github.com/tomooda/ViennaTalk-doc/blob/master/VDMBrowser.md] to learn how to use the browser.

The specification to compute total from unit price and amount is simple.

```vdmsl
functions
  total : int * int -> int
  total(unit, amount) == unit * amount;
```

Type the specification above into the specification pane and accept it.
You may test the specification on Workspace.

![VDM spec](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-VDM2.png)

Binding the GUI and VDM in Livetalk
---
Now you have a GUI and a functional specification.
You need to bind them together to obtain a working prototype.

Clicking on the <tt>Livetalk</tt> tab will bring Livetalk Browser in front.

![Livetalk Browser](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-Livetalk1.png)

Livetalk is a scripting language that associates an event on a widget with a series of actions.
The syntax is simple.

```
<livetalk> ::= 
  <widget name>`<event name><cr>        /* widget and event that triggers the actions defined below */
    <action><cr>                        /* actions are separated by <cr> */
    ...
<action> ::= 
    <expression> |                        /* evaluate the expression */
    <expression> -> [<widget name>] |     /* feed the value of the expression to the widget */
    ! <expression>                        /* show the value of the expression in a dialog */
<expression> ::=
    <operation name>(<expression>,...) |  /* call a VDM operation */
    [<widget name>]                       /* read the value that the widget holds */
    "string" |                            /* all values are string of valid VDM expressions */
```

For the simple calculator, the below script will compute the total.

```
Calc`clicked
  total( [UnitPrice] , [Amount] ) -> [Total]
```

The script will evaluate a VDM operation call with the arguments from the two field widgets (<tt>UnitPrice</tt> and <tt>Amount</tt>) and then give the resulting value to the <tt>Total</tt> widget.

![Livetalk Browser](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-Livetalk2.png)

Testdriving the prototype
---
Your prototype is ready to go.
Fill the <tt>UnitPrice</tt> and <tt>Amount</tt> in and then click on the <tt>Calc</tt> button.

![using the prototype](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-run1.png)

The result will hopefully be displayed as you expect :smile:

![result](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/Lively-run2.png)
