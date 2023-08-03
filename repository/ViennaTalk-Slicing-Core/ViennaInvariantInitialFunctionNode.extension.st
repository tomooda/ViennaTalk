Extension { #name : #ViennaInvariantInitialFunctionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaInvariantInitialFunctionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	self pattern sliceWith: aViennaSlicer
]
