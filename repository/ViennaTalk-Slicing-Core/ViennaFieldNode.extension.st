Extension { #name : #ViennaFieldNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaFieldNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self type ].
	self type sliceWith: aViennaSlicer
]
