Class {
	#name : 'ViennaConditionalStatementListNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaConditionalStatementListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'pretty printing' }
ViennaConditionalStatementListNode >> formatWith: aViennaAbstractFormatter [

	
]

{ #category : 'private' }
ViennaConditionalStatementListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaConditionalStatementListNode >> isViennaConditionalStatementListNode [

	^ true
]

{ #category : 'accessing' }
ViennaConditionalStatementListNode >> label [

	^ 'ConditionalStatementList'
]

{ #category : 'typechecking' }
ViennaConditionalStatementListNode >> maximalType [

	^ self
		  inject: ViennaType unit
		  into: [ :type :conditionalStatement |
		  type + conditionalStatement typecheck ]
]
