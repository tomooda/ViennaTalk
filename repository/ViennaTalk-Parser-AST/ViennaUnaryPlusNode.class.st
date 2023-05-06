Class {
	#name : #ViennaUnaryPlusNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaUnaryPlusNode >> label [

	^ 'UnaryPlus'
]

{ #category : #'pretty printing' }
ViennaUnaryPlusNode >> operatorPrecedence [

	^ 36
]
