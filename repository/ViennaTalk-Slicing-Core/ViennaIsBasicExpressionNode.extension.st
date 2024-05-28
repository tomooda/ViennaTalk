Extension { #name : 'ViennaIsBasicExpressionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaIsBasicExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer
]
