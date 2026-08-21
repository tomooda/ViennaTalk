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
		             documentFromString: '# Example evaluatable expressions
```vienna-eval
Counter`click()
```
```vienna-eval
Counter`show()
```';
		             yourself.
	presenter open title: 'ViennaMicrodown'.
	^ presenter
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> transpiledSpecification [

	^ transpiledSpecification
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> transpiledSpecification: anObject [

	transpiledSpecification := anObject
]
