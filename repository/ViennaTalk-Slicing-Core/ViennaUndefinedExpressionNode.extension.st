Extension { #name : #ViennaUndefinedExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaUndefinedExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
