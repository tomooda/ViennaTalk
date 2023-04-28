Class {
	#name : #ViennaConditionalExpressionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaConditionalExpressionListNode class >> withAll: anArrayOfConditionalExpressionNode [

	| list |
	list := self new: anArrayOfConditionalExpressionNode size.
	1 to: anArrayOfConditionalExpressionNode size do: [ :index |
		list at: index put: (anArrayOfConditionalExpressionNode at: index) ].
	^ list
]

{ #category : #accessing }
ViennaConditionalExpressionListNode >> label [

	^ 'ConditionalExpressionList'
]
