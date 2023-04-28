Class {
	#name : #ViennaUnaryOperatorExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaUnaryOperatorExpressionNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaUnaryOperatorExpressionNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaUnaryOperatorExpressionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]
