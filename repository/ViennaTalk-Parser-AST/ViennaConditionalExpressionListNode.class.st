Class {
	#name : #ViennaConditionalExpressionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaConditionalExpressionListNode >> isViennaConditionalExpressionListNode [

	^ true
]

{ #category : #accessing }
ViennaConditionalExpressionListNode >> label [

	^ 'ConditionalExpressionList'
]
