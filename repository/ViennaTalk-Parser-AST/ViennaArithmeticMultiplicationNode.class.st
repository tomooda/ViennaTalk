Class {
	#name : #ViennaArithmeticMultiplicationNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticMultiplicationNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter mul
]

{ #category : #'pretty printing' }
ViennaArithmeticMultiplicationNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticMultiplicationNode >> isViennaArithmeticMultiplicationNode [

	^ true
]

{ #category : #accessing }
ViennaArithmeticMultiplicationNode >> label [

	^ 'ArithmeticMultiplication'
]

{ #category : #'pretty printing' }
ViennaArithmeticMultiplicationNode >> operatorPrecedence [

	^ 32
]
