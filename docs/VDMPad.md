# VDMPad

VDMPad is a simple web IDE for VDM-SL.
It's designed to be used as a "sketch pad" for VDM-SL specifications.
You can handily write a specification, manipulate states and evaluate expressions intuitively.
Graphical representation of VDM values are also provided to easily understand the state of the animated system.

## Installation
To star a server, you simply evlauate the following Smalltalk expression.

```
VDMPad installHandler
```

A web server will start service on the port 8085.

You can open it on a browser by opening http://localhost:8085/ .

![Screenshot of VDMPad](https://viennatalk.org/images/VDMPad-plain.png)

## Write a specification
You can write a specification on the top text area.

![Counter example on VDMPad](https://viennatalk.org/images/VDMPad-counter-spec.png)

# Animate a specification
The initialize button will start animation of the specification.

![Initializing the counter example on VDMPad](https://viennatalk.org/images/VDMPad-counter-initialized.png)

An entry field for each state variable (```counter``` in this example) appears below the specification.

You can evaluate an expression in the text field below the state fields.

![Evaluating the counter example on VDMPad](https://viennatalk.org/images/VDMPad-counter-eval.png)

# Save and load an animation session

VDMPad automatically save the current animation state along with the VDM specification source after every operation on the web IDE.
You can close the web IDE any time and re-open it on the web browser with the last state of the animation.
Please note that the animation sessions are saved in your browser, not the server.

You can also manage multiple animation sessions by saving snapshots with names.

To save a snapshot,

1. Move the mouse cursor over the small square mark at the top-left of the window.
2. Type a name in the entry field and click on the "save" button.

![Evaluating the counter example on VDMPad](https://viennatalk.org/images/VDMPad-counter-save.png)

To load a saved snapshot,

1. Move the mouse cursor over the small square mark at the top-left of the window.
2. Click on the name of snapshot and then click on the "Load" button.

![Evaluating the counter example on VDMPad](https://viennatalk.org/images/VDMPad-counter-saved.png)

# Review the session

VDMPad has a module called "VDMPad-EpiLog" to review the history.
By turning on "VDMPad-EpiLog" in the settings, you'll have a history on the left (or bottom) of the VDMPad page.

![Screenshot of VDMPad-EpiLog](https://viennatalk.org/images/VDMPad-EpiLog-open.png)


The history part will look like the below.

![Screenshot of VDMPad-EpiLog](https://viennatalk.org/images/VDMPad-EpiLog-0-start.png)

The history consists of revisions of the source specification each of which has some series of evaluations.
In the history shown above, the ```inc``` operation was wrongly defined in the first revision.
The expression ```inc()``` was evaluated with the initial state where ```count = 0``` and ```macx = 9999```.
The run was as expected.
The next series was with the initial state where ```count=9``` and ```max=9```, which is expected to get ```count``` be reset to zero by evaluating ```inc()```.

The bug was in the mod operator which was fixed in the second revision.
Again, ```inc()``` was evaluated with the initial state where ```count=9``` and ```max=9```, and successfully resulted in ```count=0```.

What was tried and confirmed during the session?
The normal counting before hitting the ```max``` value was tested against only the first revision.

By clicking the ⬇️ button on the specification source, all runs evaluated agaist the first revision will be merged to the second revision.

![Screenshot of VDMPad-EpiLog](https://viennatalk.org/images/VDMPad-EpiLog-1-merge.png)

The yellow boxes means that the run has not been executed in the specification.
Such runs can be re-evaluated against the specification by the 🔄 button that appears on the box.
Less interesting revisions and runs can be removed by the 🗑 button.

After working on those revisions, the history will be finally summarized like below.

![Screenshot of VDMPad-EpiLog](https://viennatalk.org/images/VDMPad-EpiLog-4-finish.png)

