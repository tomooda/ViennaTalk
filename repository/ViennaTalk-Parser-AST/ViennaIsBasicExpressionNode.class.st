Class {
	#name : #ViennaIsBasicExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIsBasicExpressionNode class >> basicTypeName: aString expression: aViennaExpressionNode [

	^ (self new: 2)
		  basicTypeName: aString;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> basicTypeName [

	^ self at: 1
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> basicTypeName: aString [

	self at: 1 put: aString
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaIsBasicExpressionNode >> label [

	^ 'IsBasicExpression'
]
