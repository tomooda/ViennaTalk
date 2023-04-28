Class {
	#name : #ViennaConditionalStatementListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaConditionalStatementListNode class >> withAll: anArrayOfConditionalStatementNode [

	| list |
	list := self new: anArrayOfConditionalStatementNode size.
	1 to: anArrayOfConditionalStatementNode size do: [ :index |
		list at: index put: (anArrayOfConditionalStatementNode at: index) ].
	^ list
]

{ #category : #accessing }
ViennaConditionalStatementListNode >> label [

	^ 'ConditionalStatementList'
]
