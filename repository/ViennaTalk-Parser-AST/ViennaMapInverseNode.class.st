Class {
	#name : #ViennaMapInverseNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaMapInverseNode >> label [

	^ 'MapInverse'
]

{ #category : #'pretty printing' }
ViennaMapInverseNode >> operatorPrecedence [

	^ 33
]
