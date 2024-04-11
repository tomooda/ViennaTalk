Class {
	#name : #ViennaExpressionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExpressionListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaExpressionListNode >> formatWith: aViennaAbstractFormatter [

	| expressions |
	expressions := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join:
			  ',' , ((aViennaAbstractFormatter anyNeedsIndent: expressions)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: expressions
]

{ #category : #private }
ViennaExpressionListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :expression |
		expression freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaExpressionListNode >> isViennaExpressionListNode [

	^ true
]

{ #category : #accessing }
ViennaExpressionListNode >> label [

	^ 'ExpressionList'
]

{ #category : #private }
ViennaExpressionListNode >> listDelimiter [

	^ ', '
]

{ #category : #typechecking }
ViennaExpressionListNode >> maximalType [

	^ ViennaType product: (self collect: #typecheck)
]
