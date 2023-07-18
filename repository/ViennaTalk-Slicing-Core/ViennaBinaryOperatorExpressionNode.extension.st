Extension { #name : #ViennaBinaryOperatorExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaBinaryOperatorExpressionNode >> sliceWith: aViennaSlicer [

	self expression2 sliceWith: aViennaSlicer.
	self expression1 sliceWith: aViennaSlicer
]
