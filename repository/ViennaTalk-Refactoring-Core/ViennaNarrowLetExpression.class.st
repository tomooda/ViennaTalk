Class {
	#name : #ViennaNarrowLetExpression,
	#superclass : #ViennaNarrowLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaNarrowLetExpression >> acceptsNode: aViennaNode [

	^ aViennaNode isViennaLetExpressionNode
]

{ #category : #accessing }
ViennaNarrowLetExpression >> sortingOrder [
	^ 3.52
]
