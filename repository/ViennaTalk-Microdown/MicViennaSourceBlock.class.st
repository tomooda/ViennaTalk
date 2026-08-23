"
I am a script block to show VDM-SL specification sources with syntax highlighting.

For example,
```text
 ```vienna-source
 ```
```

will render a specification source for example as follows.
```vdmsl
module Counter
exports all
definitions
state Counter of
    count : nat
init s == s = mk_Counter
end
operations
click : () ==> ()
click() == count := count + 1;
show : () ==> nat
show() == return nat
end Counter
```
"
Class {
	#name : 'MicViennaSourceBlock',
	#superclass : 'MicViennaBlock',
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'accessing' }
MicViennaSourceBlock class >> tag [

	^ #'vienna-source'
]

{ #category : 'visiting' }
MicViennaSourceBlock >> accept: aVisitor [

	aVisitor visitViennaSource: self
]

{ #category : 'accessing' }
MicViennaSourceBlock >> execute [

	resultString := nil.
	errorString := nil.
	self receiver ifNotNil: [ :receiver |
			self bodyNode
				ifNotNil: [ :bodyNode |
						bodyNode isPetit2Success ifTrue: [
								resultString := (bodyNode
									                 parent: receiver;
									                 resolve) highlightedSource ] ]
				ifNil: [ resultString := receiver highlightedSource ] ]
]

{ #category : 'accessing' }
MicViennaSourceBlock >> parser [

	^ ViennaVDMParser new name optional
]
