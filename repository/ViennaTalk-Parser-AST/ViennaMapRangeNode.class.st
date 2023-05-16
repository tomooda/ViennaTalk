Class {
	#name : #ViennaMapRangeNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapRangeNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'rng'
]

{ #category : #accessing }
ViennaMapRangeNode >> label [

	^ 'MapRange'
]

{ #category : #'pretty printing' }
ViennaMapRangeNode >> operatorPrecedence [

	^ 36
]
