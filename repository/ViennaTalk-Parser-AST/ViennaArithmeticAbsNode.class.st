Class {
	#name : #ViennaArithmeticAbsNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticAbsNode >> formatWith: aViennaAbstractFormatter [

	^ 'abs ' , (aViennaAbstractFormatter format: self expression)
]

{ #category : #accessing }
ViennaArithmeticAbsNode >> label [

	^ 'ArithmeticAbs'
]

{ #category : #'pretty printing' }
ViennaArithmeticAbsNode >> operatorPrecedence [

	^ 36
]
