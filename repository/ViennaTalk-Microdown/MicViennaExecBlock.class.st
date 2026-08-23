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
	#name : 'MicViennaExecBlock',
	#superclass : 'MicViennaAnimationBlock',
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'accessing' }
MicViennaExecBlock class >> tag [

	^ #'vienna-exec'
]

{ #category : 'visiting' }
MicViennaExecBlock >> accept: aVisitor [

	aVisitor visitViennaExec: self
]

{ #category : 'accessing' }
MicViennaExecBlock >> parser [

	^ ViennaVDMParser new statement
]
