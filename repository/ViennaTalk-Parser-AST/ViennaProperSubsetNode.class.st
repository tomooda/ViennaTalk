Class {
	#name : #ViennaProperSubsetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaProperSubsetNode >> label [

	^ 'ProperSubset'
]

{ #category : #'pretty printing' }
ViennaProperSubsetNode >> operatorPrecedence [

	^ 21
]