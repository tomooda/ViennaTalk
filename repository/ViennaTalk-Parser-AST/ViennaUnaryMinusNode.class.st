Class {
	#name : #ViennaUnaryMinusNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaUnaryMinusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '-'
]

{ #category : #accessing }
ViennaUnaryMinusNode >> label [

	^ 'UnaryMinus'
]

{ #category : #'pretty printing' }
ViennaUnaryMinusNode >> operatorPrecedence [

	^ 36
]
