Class {
	#name : #ViennaConditionalStatementListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaConditionalStatementListNode >> isViennaConditionalStatementListNode [

	^ true
]

{ #category : #accessing }
ViennaConditionalStatementListNode >> label [

	^ 'ConditionalStatementList'
]
