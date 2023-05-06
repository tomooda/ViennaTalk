Class {
	#name : #ViennaArithmeticPlusNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticPlusNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticPlusNode >> label [

	^ 'ArithmeticPlus'
]

{ #category : #'pretty printing' }
ViennaArithmeticPlusNode >> operatorPrecedence [

	^ 31
]
