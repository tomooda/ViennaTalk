Class {
	#name : #ViennaConditionalExpressionListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaConditionalExpressionListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaConditionalExpressionListNode >> formatWith: aViennaAbstractFormatter [

	
]

{ #category : #private }
ViennaConditionalExpressionListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaConditionalExpressionListNode >> isViennaConditionalExpressionListNode [

	^ true
]

{ #category : #accessing }
ViennaConditionalExpressionListNode >> label [

	^ 'ConditionalExpressionList'
]
