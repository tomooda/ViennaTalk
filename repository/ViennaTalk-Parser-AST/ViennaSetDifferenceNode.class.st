Class {
	#name : #ViennaSetDifferenceNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSetDifferenceNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaSetDifferenceNode >> label [

	^ 'SetDifference'
]

{ #category : #'pretty printing' }
ViennaSetDifferenceNode >> operatorPrecedence [

	^ 31
]
