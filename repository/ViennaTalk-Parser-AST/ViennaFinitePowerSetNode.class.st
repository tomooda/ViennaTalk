Class {
	#name : #ViennaFinitePowerSetNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaFinitePowerSetNode >> label [

	^ 'FinitePowerSet'
]

{ #category : #'pretty printing' }
ViennaFinitePowerSetNode >> operatorPrecedence [

	^ 36
]
