Class {
	#name : #ViennaSetCardinalityNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSetCardinalityNode >> label [

	^ 'SetCardinality'
]

{ #category : #'pretty printing' }
ViennaSetCardinalityNode >> operatorPrecedence [

	^ 36
]