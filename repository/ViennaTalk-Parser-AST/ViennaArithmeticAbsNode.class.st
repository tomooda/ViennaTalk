Class {
	#name : #ViennaArithmeticAbsNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaArithmeticAbsNode >> label [

	^ 'ArithmeticAbs'
]

{ #category : #'pretty printing' }
ViennaArithmeticAbsNode >> operatorPrecedence [

	^ 36
]
