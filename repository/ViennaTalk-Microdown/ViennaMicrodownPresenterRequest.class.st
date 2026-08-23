"
I am an exception to retrieve a ViennaMicrodownPresenter who will render me.
For example, when you execute an expression or a statement, you need a transpiled modular document associated with the presenter, but sometimes you have no way to access via variables and messages to them.
I provide a way to pass the presenter for such cases.

Before you execute a code that needs the presenter, you set up an exception handler that will give the presenter, as follows.

```
[ ... calls-some-code-that-needs-the-presenter-but-have-no-way-to-pass-it-via-a-variable-or-an-argument... ] on: ViennaMicrodownPresenterRequest do: [:ex | ex resume: thePresenter]
```

You can retrieve a transpiled document by the following code.

```
presenter := ViennaMicrodownPresenterRequest signal.
```

If no handler is set, nil will be passed as the default.
"
Class {
	#name : 'ViennaMicrodownPresenterRequest',
	#superclass : 'Exception',
	#category : 'ViennaTalk-Microdown-Spec2',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Spec2'
}

{ #category : 'handling' }
ViennaMicrodownPresenterRequest >> defaultAction [
	"No action is taken. The value nil is returned as the value of the message that signaled the exception."

	^nil
]
