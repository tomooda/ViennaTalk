Extension { #name : 'ViennaTypeVariableNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTypeVariableNode >> sliceWith: aViennaSlicer [

	| typeVar |
	typeVar := self variableIdentifier resolve.
	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: typeVar ].
	typeVar sliceWith: aViennaSlicer
]
