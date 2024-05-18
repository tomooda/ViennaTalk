Class {
	#name : 'ViennaExpressionListNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaExpressionListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'pretty printing' }
ViennaExpressionListNode >> formatWith: aViennaAbstractFormatter [

	| expressions |
	expressions := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter empty ++ ','
			  ++ ((aViennaAbstractFormatter anyNeedsIndent: expressions)
					   ifTrue: [ aViennaAbstractFormatter cr ]
					   ifFalse: [ aViennaAbstractFormatter space ])
		  withAll: expressions
]

{ #category : 'private' }
ViennaExpressionListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :expression |
		expression freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaExpressionListNode >> isViennaExpressionListNode [

	^ true
]

{ #category : 'accessing' }
ViennaExpressionListNode >> label [

	^ 'ExpressionList'
]

{ #category : 'private' }
ViennaExpressionListNode >> listDelimiter [

	^ ', '
]

{ #category : 'typechecking' }
ViennaExpressionListNode >> maximalType [

	^ ViennaType product: (self collect: #typecheck)
]
