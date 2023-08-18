Extension { #name : #ViennaUnaryTypeConstructorNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaUnaryTypeConstructorNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self type ].
	self type sliceWith: aViennaSlicer
]
