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

![Screenshot of VDMPad](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMPad-plain.png)

## Write a specification
You can write a specification on the top text area.

![Counter example on VDMPad](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMPad-counter-spec.png)

# Animate a specification
The initialize button will start animation of the specification.

![Initializing the counter example on VDMPad](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMPad-counter-initialized.png)

An entry field for each state variable (```counter``` in this example) appears below the specification.

You can evaluate an expression in the text field below the state fields.

![Evaluating the counter example on VDMPad](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMPad-counter-eval.png)

# Save and load an animation session

VDMPad automatically save the current animation state along with the VDM specification source after every operation on the web IDE.
You can close the web IDE any time and re-open it on the web browser with the last state of the animation.
Please note that the animation sessions are saved in your browser, not the server.

You can also manage multiple animation sessions by saving snapshots with names.

To save a snapshot,

1. Move the mouse cursor over the small square mark at the top-left of the window.
2. Type a name in the entry field and click on the "save" button.

![Evaluating the counter example on VDMPad](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMPad-counter-save.png)

To load a saved snapshot,

1. Move the mouse cursor over the small square mark at the top-left of the window.
2. Click on the name of snapshot and then click on the "Load" button.

![Evaluating the counter example on VDMPad](https://github.com/tomooda/ViennaTalk-doc/blob/master/images/VDMPad-counter-saved.png)




