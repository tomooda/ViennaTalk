Class {
	#name : #ViennaConditionalStatementListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaConditionalStatementListNode >> boundIdentifiersInto: aSet [

	
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
