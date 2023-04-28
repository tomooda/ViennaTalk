Class {
	#name : #ViennaIsNameExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIsNameExpressionNode class >> name: aViennaNameNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> label [

	^ 'IsNameExpression'
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
