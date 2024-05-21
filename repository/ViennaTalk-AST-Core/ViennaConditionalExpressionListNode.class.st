Class {
	#name : 'ViennaConditionalExpressionListNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaConditionalExpressionListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'pretty printing' }
ViennaConditionalExpressionListNode >> formatWith: aViennaAbstractFormatter [

	
]

{ #category : 'private' }
ViennaConditionalExpressionListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaConditionalExpressionListNode >> isViennaConditionalExpressionListNode [

	^ true
]

{ #category : 'accessing' }
ViennaConditionalExpressionListNode >> label [

	^ 'ConditionalExpressionList'
]

{ #category : 'typechecking' }
ViennaConditionalExpressionListNode >> maximalType [

	^ self
		  inject: ViennaType unit
		  into: [ :type :conditionalExpression |
			  type + conditionalExpression typecheck ]
]

{ #category : 'typechecking' }
ViennaConditionalExpressionListNode >> maximalType: aViennaType [

	^ self do: [ :conditionalExpression |
		  conditionalExpression maximalType: aViennaType ]
]
