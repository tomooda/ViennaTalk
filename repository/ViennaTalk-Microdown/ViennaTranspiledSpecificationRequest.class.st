"
I am an exception to retrieve a transpiled modular document.
For example, when you execute an expression or a statement, you need a transpiled modular document but sometimes you have no way to access via variables and messages to them.
I provide a way to pass a transpiled document for such cases.

Before you execute a code that needs a transpiled document, you set up an exception handler that will give the transpiled document, as follows.
```
[ ... calls-some-code-that-needs-the-transpiled-module-but-have-no-way-to-pass-it-via-a-variable-or-an-argument... ] on: ViennaTranspiledSpecificationRequest do: [:ex | ex resume: theTranspiledModularDocument]
```

You can retrieve a transpiled document by the following code.
```
object := ViennaTranspiledSpecificationRequest signal.
```

"
Class {
	#name : 'ViennaTranspiledSpecificationRequest',
	#superclass : 'Exception',
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'handling' }
ViennaTranspiledSpecificationRequest >> defaultAction [
	"No action is taken. The value nil is returned as the value of the message that signaled the exception."

	^nil
]
