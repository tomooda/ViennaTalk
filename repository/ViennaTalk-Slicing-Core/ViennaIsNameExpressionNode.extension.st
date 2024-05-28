Extension { #name : 'ViennaIsNameExpressionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaIsNameExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression;
			read: self name ].
	self expression sliceWith: aViennaSlicer.
	self name sliceWith: aViennaSlicer
]
