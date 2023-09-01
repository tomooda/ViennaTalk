Extension { #name : #ViennaResultExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaResultExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
