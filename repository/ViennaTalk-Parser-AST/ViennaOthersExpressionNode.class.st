Class {
	#name : #ViennaOthersExpressionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOthersExpressionNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #private }
ViennaOthersExpressionNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #accessing }
ViennaOthersExpressionNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaOthersExpressionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaOthersExpressionNode >> formatWith: aViennaAbstractFormatter [

	| expression |
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: 'others ->'
		  insertCrIfNeeded: expression
]

{ #category : #testing }
ViennaOthersExpressionNode >> isViennaOthersExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaOthersExpressionNode >> label [

	^ 'OthersExpression'
]
