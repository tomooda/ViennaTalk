Extension { #name : #ViennaExists1ExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaExists1ExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	self bind sliceWith: aViennaSlicer
]
