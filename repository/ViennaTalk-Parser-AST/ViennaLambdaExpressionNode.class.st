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

{ #category : #'parsers-patterns' }
ViennaLambdaExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-patterns' }
ViennaLambdaExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> label [

	^ 'LambdaExpression'
]

{ #category : #'parsers-patterns' }
ViennaLambdaExpressionNode >> typeBindList [

	^ self at: 1
]

{ #category : #'parsers-patterns' }
ViennaLambdaExpressionNode >> typeBindList: aViennaTypeBindListNode [

	self at: 1 put: aViennaTypeBindListNode
]
