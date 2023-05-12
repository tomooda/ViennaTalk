Class {
	#name : #ViennaArithmeticAbsNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticAbsNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'abs'
]

{ #category : #accessing }
ViennaArithmeticAbsNode >> label [

	^ 'ArithmeticAbs'
]

{ #category : #'pretty printing' }
ViennaArithmeticAbsNode >> operatorPrecedence [

	^ 36
]
