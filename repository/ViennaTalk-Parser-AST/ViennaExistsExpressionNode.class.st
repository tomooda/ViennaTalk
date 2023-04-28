Class {
	#name : #ViennaExistsExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExistsExpressionNode class >> bindList: aViennaBindListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bindList: aViennaBindListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'parsers-patterns' }
ViennaExistsExpressionNode >> bindList [

	^ self at: 1
]

{ #category : #'parsers-patterns' }
ViennaExistsExpressionNode >> bindList: aViennaBindListNode [

	self at: 1 put: aViennaBindListNode
]

{ #category : #'parsers-patterns' }
ViennaExistsExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-patterns' }
ViennaExistsExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExistsExpressionNode >> label [

	^ 'ExistsExpression'
]
