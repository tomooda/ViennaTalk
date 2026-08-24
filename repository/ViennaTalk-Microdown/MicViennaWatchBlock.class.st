"
I am a script block for evaluatable VDM-SL expressions.
I will render the content as a VDM-SL expression with syntax highlighting.
A 'run' label in gray background is appended to evaluate it and print the resulting value.

For example,
```text
 ```vienna-eval
 3+4
 ```
```
is rendered as
```vienna-eval
3+4
```
Also,
```text
 ```vienna-eval
 {1 |-> ""1"", 2 |-> ""2"", 3 |-> ""3""} ++ {3 |-> ""three"", 4 |-> ""four"", 5 |-> ""five""}
 ```
```
is rendered as
```vienna-eval
{1 |-> ""1"", 2 |-> ""2"", 3 |-> ""3""} ++ {3 |-> ""three"", 4 |-> ""four"", 5 |-> ""five""}
```
"
Class {
	#name : 'MicViennaWatchBlock',
	#superclass : 'MicViennaBlock',
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'accessing' }
MicViennaWatchBlock class >> tag [

	^ #'vienna-watch'
]

{ #category : 'visiting' }
MicViennaWatchBlock >> accept: aVisitor [

	aVisitor visitViennaWatch: self
]

{ #category : 'private' }
MicViennaWatchBlock >> createVdmParser [

	^ ViennaVDMParser new name
]

{ #category : 'defaults' }
MicViennaWatchBlock >> defaultState [

	^ #no
]

{ #category : 'executing' }
MicViennaWatchBlock >> execute [

	| nameNode state |
	resultString := nil.
	errorString := nil.
	nameNode := self bodyNode ifNil: [ ^ self syntaxError ].
	state := self animation state.
	^ nameNode isViennaGlobalNameNode
		  ifTrue: [
				  state
					  at: nameNode source
					  ifPresent: [ :value | self resultString: (self vdmHighlight: value) ]
					  ifAbsent: [ self undefinedVariableError: nameNode source ] ]
		  ifFalse: [
				  self moduleName
					  ifNotNil: [ :moduleName |
							  state
								  at: moduleName , '`' , nameNode identifier
								  ifPresent: [ :value | self resultString: (self vdmHighlight: value) ]
								  ifAbsent: [ self undefinedVariableError: nameNode source ] ]
					  ifNil: [ self undefinedVariableError: nameNode source ] ]
]

{ #category : 'accessing' }
MicViennaWatchBlock >> state [

	^ #no
]
