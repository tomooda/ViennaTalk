Class {
	#name : #ViennaForallExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaForallExpressionNode class >> bindList: aViennaBindListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bindList: aViennaBindListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'parsers-patterns' }
ViennaForallExpressionNode >> bindList [

	^ self at: 1
]

{ #category : #'parsers-patterns' }
ViennaForallExpressionNode >> bindList: aViennaBindListNode [

	self at: 1 put: aViennaBindListNode
]

{ #category : #'parsers-patterns' }
ViennaForallExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-patterns' }
ViennaForallExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaForallExpressionNode >> label [

	^ 'ForallExpression'
]
