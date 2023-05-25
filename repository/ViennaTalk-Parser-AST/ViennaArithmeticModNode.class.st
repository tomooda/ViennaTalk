Class {
	#name : #ViennaArithmeticModNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticModNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'mod'
]

{ #category : #'pretty printing' }
ViennaArithmeticModNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticModNode >> isViennaArithmeticModNode [

	^ true
]

{ #category : #accessing }
ViennaArithmeticModNode >> label [

	^ 'ArithmeticMod'
]

{ #category : #'pretty printing' }
ViennaArithmeticModNode >> operatorPrecedence [

	^ 32
]
