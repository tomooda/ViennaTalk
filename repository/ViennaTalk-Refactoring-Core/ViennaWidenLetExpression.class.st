Class {
	#name : 'ViennaWidenLetExpression',
	#superclass : 'ViennaWidenLet',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaWidenLetExpression >> acceptsDefinitionNode: aViennaNode [
	^ aViennaNode isViennaExpressionNode
]

{ #category : 'testing' }
ViennaWidenLetExpression >> acceptsNode: aViennaNode [

	^ aViennaNode isViennaLetExpressionNode
]

{ #category : 'accessing' }
ViennaWidenLetExpression >> sortingOrder [
	^ 3.62
]
