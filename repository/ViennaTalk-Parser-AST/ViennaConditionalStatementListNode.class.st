Class {
	#name : #ViennaConditionalStatementListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaConditionalStatementListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaConditionalStatementListNode >> formatWith: aViennaAbstractFormatter [

	
]

{ #category : #private }
ViennaConditionalStatementListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaConditionalStatementListNode >> isViennaConditionalStatementListNode [

	^ true
]

{ #category : #accessing }
ViennaConditionalStatementListNode >> label [

	^ 'ConditionalStatementList'
]
