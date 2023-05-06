Class {
	#name : #ViennaFloorNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaFloorNode >> label [

	^ 'Floor'
]

{ #category : #'pretty printing' }
ViennaFloorNode >> operatorPrecedence [

	^ 36
]
