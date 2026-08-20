"
I am a script block for evaluatable VDM-SL expressions.
I will render the content as a VDM-SL expression with syntax highlighting.
A green triangle is appended to mension that the expression is clickable to evaluate and print the resulting value.

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
	#name : 'MicViennaEvalBlockScriptBlock',
	#superclass : 'MicScriptBlock',
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'accessing' }
MicViennaEvalBlockScriptBlock class >> tag [

	^ #'vienna-eval'
]

{ #category : 'visiting' }
MicViennaEvalBlockScriptBlock >> accept: aVisitor [

	aVisitor visitViennaEvalScript: self
]

{ #category : 'executing' }
MicViennaEvalBlockScriptBlock >> execute [

	| source |
	source := self body asString.
	^ self receiver ifNotNil: [ :receiver | receiver evaluateExpression: source ifError: [ :message | message ] ] ifNil: [
			  | src |
			  src := ViennaVDM2SmalltalkClass new generate: source asViennaExpressionAst.
			  OpalCompiler new
				  source: src;
				  logged: false;
				  receiver: nil;
				  evaluate ]
]

{ #category : 'accessing' }
MicViennaEvalBlockScriptBlock >> moduleName [

	^ arguments at: #module ifAbsent: [ nil ]
]

{ #category : 'accessing' }
MicViennaEvalBlockScriptBlock >> receiver [

	^ ViennaTranspiledSpecificationRequest signal ifNotNil: [ :document | document at: self moduleName ifAbsent: [ nil ] ]
]
