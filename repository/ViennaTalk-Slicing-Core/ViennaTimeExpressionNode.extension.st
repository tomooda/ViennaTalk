Extension { #name : 'ViennaTimeExpressionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTimeExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
