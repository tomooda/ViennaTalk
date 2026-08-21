"
I am a script block for evaluatable VDM-SL expressions.
I will render the content as a VDM-SL expression with syntax highlighting.
A 'run' label in gray background is appended to evaluate it and print the resulting value.

For example,
```text
 ```vienna-exec
 (dcl sum : nat := 0;
 for i = 0 to 10 do
     sum := sum + i;
 return sum)
 ```
```
is rendered as
```vienna-exec
 (dcl sum : nat := 0;
 for i = 0 to 10 do
     sum := sum + i;
 return sum)
```
"
Class {
	#name : 'MicViennaExecBlockScriptBlock',
	#superclass : 'MicScriptBlock',
	#instVars : [
		'presenter'
	],
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'accessing' }
MicViennaExecBlockScriptBlock class >> tag [

	^ #'vienna-exec'
]

{ #category : 'visiting' }
MicViennaExecBlockScriptBlock >> accept: aVisitor [

	aVisitor visitViennaExecBlockScript: self
]

{ #category : 'executing' }
MicViennaExecBlockScriptBlock >> execute [

	| source |
	source := self body asString.
	^ self receiver ifNotNil: [ :receiver | receiver evaluateStatement: source ifError: [ :message | message ] ] ifNil: [
			  | src |
			  src := ViennaVDM2SmalltalkObject new generate: source asViennaStatementAst.
			  OpalCompiler new
				  source: src;
				  logged: false;
				  receiver: nil;
				  evaluate ]
]

{ #category : 'accessing' }
MicViennaExecBlockScriptBlock >> moduleName [

	^ arguments at: #module ifAbsent: [ nil ]
]

{ #category : 'accessing' }
MicViennaExecBlockScriptBlock >> receiver [

	^ self transpiledSpecification ifNotNil: [ :transpiledSpec |
		  self moduleName ifNotNil: [ :moduleName | transpiledSpec at: moduleName ifAbsent: [ nil ] ] ifNil: [ transpiledSpec ] ]
]

{ #category : 'private' }
MicViennaExecBlockScriptBlock >> retrievePresenter [

	presenter := ViennaMicrodownPresenterRequest signal
]

{ #category : 'accessing' }
MicViennaExecBlockScriptBlock >> transpiledSpecification [

	^ presenter ifNotNil: #transpiledSpecification 
]
