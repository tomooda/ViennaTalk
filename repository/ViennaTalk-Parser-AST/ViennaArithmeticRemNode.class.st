Class {
	#name : #ViennaArithmeticRemNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticRemNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticRemNode >> label [

	^ 'ArithmeticRem'
]

{ #category : #'pretty printing' }
ViennaArithmeticRemNode >> operatorPrecedence [

	^ 32
]
