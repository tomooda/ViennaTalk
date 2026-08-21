"
I am a presenter that renders a markdown with ViennaDoc-like extension that let the user to evaluate VDM-SL expressions and statements.
"
Class {
	#name : 'ViennaMicrodownPresenter',
	#superclass : 'MicrodownPresenter',
	#instVars : [
		'transpiledSpecification'
	],
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'specs' }
ViennaMicrodownPresenter class >> adapterName [

	^ #ViennaMorphicMicrodownAdapter
]

{ #category : 'examples' }
ViennaMicrodownPresenter class >> example [

	| spec transpiledSpec presenter |
	spec := 'module Counter
exports all
definitions
state Counter of
    count : nat
init s == s = mk_Counter(0)
end
operations
click : () ==> ()
click() == count := count + 1;
show : () ==> nat
show() == return count;
end Counter' asViennaDocumentAst.
	transpiledSpec := ViennaVDM2SmalltalkObject new generate: spec.
	presenter := ViennaMicrodownPresenter new
		             transpiledSpecification: transpiledSpec;
		             documentFromString: '# Example evaluatable documentation
## Public Operations

```vienna-eval
Counter`click()
```
In the Counter module,
```vienna-eval|module=Counter
show()
```

## The source
```vienna-source|module=Counter
```
';
		             yourself.
	presenter open title: 'ViennaMicrodown'.
	^ presenter
]

{ #category : 'composing' }
ViennaMicrodownPresenter >> compose [

	self withAdapterDo: [ :microdownAdapter | microdownAdapter compose ]
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> transpiledSpecification [

	^ transpiledSpecification
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> transpiledSpecification: anObject [

	transpiledSpecification := anObject
]
