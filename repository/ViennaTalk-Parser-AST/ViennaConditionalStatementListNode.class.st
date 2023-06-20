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

{ #category : #testing }
ViennaConditionalStatementListNode >> isViennaConditionalStatementListNode [

	^ true
]

{ #category : #accessing }
ViennaConditionalStatementListNode >> label [

	^ 'ConditionalStatementList'
]
