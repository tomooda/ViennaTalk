Class {
	#name : 'ViennaPrePostFunctionDefinitionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaPrePostFunctionDefinitionNode class >> expression: aViennaExpressionNode [

	^ self with: aViennaExpressionNode
]

{ #category : 'converting' }
ViennaPrePostFunctionDefinitionNode >> asArrayOfConjuncts [

	^ self body asArrayOfConjuncts
]

{ #category : 'accessing' }
ViennaPrePostFunctionDefinitionNode >> body [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaPrePostFunctionDefinitionNode >> body: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'private' }
ViennaPrePostFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	self body boundIdentifiersDo: aBlock
]

{ #category : 'pretty printing' }
ViennaPrePostFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ self body formatWith: aViennaAbstractFormatter
]

{ #category : 'private' }
ViennaPrePostFunctionDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self body freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'accessing' }
ViennaPrePostFunctionDefinitionNode >> label [

	^ 'PrePostFunctionDefinition'
]

{ #category : 'typechecking' }
ViennaPrePostFunctionDefinitionNode >> maximalType [

	^ self parent maximalTypeOfPrePostDefinition: self
]
