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

{ #category : #accessing }
ViennaForallExpressionNode >> bindList [

	^ self at: 1
]

{ #category : #accessing }
ViennaForallExpressionNode >> bindList: aViennaBindListNode [

	self at: 1 put: aViennaBindListNode
]

{ #category : #accessing }
ViennaForallExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaForallExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaForallExpressionNode >> label [

	^ 'ForallExpression'
]

{ #category : #'pretty printing' }
ViennaForallExpressionNode >> operatorPrecedence [

	^ 10
]
