Class {
	#name : #ViennaSetCardinalityNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSetCardinalityNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'card'
]

{ #category : #accessing }
ViennaSetCardinalityNode >> isViennaSetCardinalityNode [

	^ true
]

{ #category : #accessing }
ViennaSetCardinalityNode >> label [

	^ 'SetCardinality'
]

{ #category : #'pretty printing' }
ViennaSetCardinalityNode >> operatorPrecedence [

	^ 36
]
