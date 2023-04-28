Class {
	#name : #ViennaConditionalExpressionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaConditionalExpressionNode class >> condition: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 2)
		  condition: aViennaExpressionNode1;
		  expression: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> condition [

	^ self at: 1
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> condition: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaConditionalExpressionNode >> label [

	^ 'ConditionalExpression'
]
