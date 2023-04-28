Class {
	#name : #ViennaBinaryOperatorExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaBinaryOperatorExpressionNode class >> expression: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 2)
		  expression1: aViennaExpressionNode1;
		  expression2: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaBinaryOperatorExpressionNode >> expression1 [

	^ self at: 1
]

{ #category : #accessing }
ViennaBinaryOperatorExpressionNode >> expression1: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaBinaryOperatorExpressionNode >> expression2 [

	^ self at: 2
]

{ #category : #accessing }
ViennaBinaryOperatorExpressionNode >> expression2: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
