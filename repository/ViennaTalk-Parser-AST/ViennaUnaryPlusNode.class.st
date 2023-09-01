Class {
	#name : #ViennaUnaryPlusNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaUnaryPlusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '+'
]

{ #category : #testing }
ViennaUnaryPlusNode >> isViennaUnaryPlusNode [

	^ true
]

{ #category : #accessing }
ViennaUnaryPlusNode >> label [

	^ 'UnaryPlus'
]

{ #category : #'pretty printing' }
ViennaUnaryPlusNode >> operatorPrecedence [

	^ 36
]
