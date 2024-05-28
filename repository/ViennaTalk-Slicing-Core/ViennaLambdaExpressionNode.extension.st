Extension { #name : 'ViennaLambdaExpressionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaLambdaExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	self typeBindList do: [ :typeBind |
		typeBind sliceWith: aViennaSlicer ]
]
