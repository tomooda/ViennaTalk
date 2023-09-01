Extension { #name : #ViennaSetRangeExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSetRangeExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self startExpression;
			read: self endExpression ].
	self endExpression sliceWith: aViennaSlicer.
	self startExpression sliceWith: aViennaSlicer
]
