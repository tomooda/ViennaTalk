Extension { #name : 'ViennaBinaryOperatorExpressionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaBinaryOperatorExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression2;
			read: self expression1 ].
	self expression2 sliceWith: aViennaSlicer.
	self expression1 sliceWith: aViennaSlicer
]
