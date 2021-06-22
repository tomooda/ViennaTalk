Class {
	#name : #ViennaWidenLetExpression,
	#superclass : #ViennaWidenLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaWidenLetExpression >> acceptsAstLabel: aString [
	^ aString = 'LetExpression'
]

{ #category : #testing }
ViennaWidenLetExpression >> acceptsDefinitionNode: aViennaNode [
	^ aViennaNode isExpressionNode
]

{ #category : #accessing }
ViennaWidenLetExpression >> sortingOrder [
	^ 3.62
]
