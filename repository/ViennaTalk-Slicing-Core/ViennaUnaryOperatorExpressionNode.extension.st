Extension { #name : #ViennaUnaryOperatorExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaUnaryOperatorExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
