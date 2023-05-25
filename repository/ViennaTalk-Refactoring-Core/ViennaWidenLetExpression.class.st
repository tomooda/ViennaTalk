Class {
	#name : #ViennaWidenLetExpression,
	#superclass : #ViennaWidenLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaWidenLetExpression >> acceptsDefinitionNode: aViennaNode [
	^ aViennaNode isViennaExpressionNode
]

{ #category : #testing }
ViennaWidenLetExpression >> acceptsNode: aViennaNode [

	^ aViennaNode isViennaLetExpressionNode
]

{ #category : #operations }
ViennaWidenLetExpression >> check [

	ast ifNil: [ ^ false ].
	(self accceptsNode: ast) ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaWidenLetExpression >> sortingOrder [
	^ 3.62
]
