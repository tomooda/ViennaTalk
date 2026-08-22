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
	#superclass : 'MicViennaAnimationBlock',
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'accessing' }
MicViennaWatchBlock class >> tag [

	^ #'vienna-watch'
]

{ #category : 'visiting' }
MicViennaWatchBlock >> accept: aVisitor [

	aVisitor visitViennaWatch: self
]

{ #category : 'defaults' }
MicViennaWatchBlock >> defaultState [

	^ #no
]

{ #category : 'accessing' }
MicViennaWatchBlock >> parser [

	^ ViennaVDMParser new expression
]

{ #category : 'accessing' }
MicViennaWatchBlock >> state [

	^ #no
]
