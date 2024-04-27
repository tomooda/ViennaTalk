Class {
	#name : #ViennaOthersExpressionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
		  indentString: (aViennaAbstractFormatter keyword: 'others ')
			  , aViennaAbstractFormatter arrow
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaOthersExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaOthersExpressionNode >> isViennaOthersExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaOthersExpressionNode >> label [

	^ 'OthersExpression'
]

{ #category : #typechecking }
ViennaOthersExpressionNode >> maximalType [

	^ self expression typecheck
]
