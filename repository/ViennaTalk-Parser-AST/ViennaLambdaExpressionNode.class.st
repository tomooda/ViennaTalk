Class {
	#name : #ViennaLambdaExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLambdaExpressionNode class >> typeBindList: aViennaTypeBindListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  typeBindList: aViennaTypeBindListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> label [

	^ 'LambdaExpression'
]

{ #category : #'pretty printing' }
ViennaLambdaExpressionNode >> operatorPrecedence [

	^ 10
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> typeBindList [

	^ self at: 1
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> typeBindList: aViennaTypeBindListNode [

	self at: 1 put: aViennaTypeBindListNode
]
