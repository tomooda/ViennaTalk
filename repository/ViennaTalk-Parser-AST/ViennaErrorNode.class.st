Class {
	#name : #ViennaErrorNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaErrorNode class >> identifier: aString expression: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 3)
		  identifier: aString;
		  expression1: aViennaExpressionNode1;
		  expression2: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaErrorNode >> expression1 [

	^ self at: 2
]

{ #category : #accessing }
ViennaErrorNode >> expression1: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaErrorNode >> expression2 [

	^ self at: 3
]

{ #category : #accessing }
ViennaErrorNode >> expression2: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaErrorNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaErrorNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaErrorNode >> label [

	^ 'Error'
]
