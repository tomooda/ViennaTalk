Class {
	#name : #ViennaIfExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIfExpressionNode class >> conditionalExpressionList: aViennaConditionalExpressionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  conditionalExpressionList: aViennaConditionalExpressionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaIfExpressionNode >> conditionalExpressionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaIfExpressionNode >> conditionalExpressionList: aViennaConditionalExpressionListNode [

	self at: 1 put: aViennaConditionalExpressionListNode
]

{ #category : #accessing }
ViennaIfExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaIfExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaIfExpressionNode >> label [

	^ 'IfExpression'
]

{ #category : #'pretty printing' }
ViennaIfExpressionNode >> operatorPrecedence [

	^ 10
]
