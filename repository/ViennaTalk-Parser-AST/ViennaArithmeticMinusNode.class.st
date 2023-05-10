Class {
	#name : #ViennaArithmeticMinusNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticMinusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '-'
]

{ #category : #'pretty printing' }
ViennaArithmeticMinusNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticMinusNode >> label [

	^ 'ArithmeticMinus'
]

{ #category : #'pretty printing' }
ViennaArithmeticMinusNode >> operatorPrecedence [

	^ 31
]
