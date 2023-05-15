Class {
	#name : #ViennaArithmeticIntegerDivisionNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticIntegerDivisionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'div'
]

{ #category : #'pretty printing' }
ViennaArithmeticIntegerDivisionNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticIntegerDivisionNode >> label [

	^ 'ArithmeticIntegerDivision'
]

{ #category : #'pretty printing' }
ViennaArithmeticIntegerDivisionNode >> operatorPrecedence [

	^ 32
]