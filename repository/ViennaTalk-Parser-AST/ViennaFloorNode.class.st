Class {
	#name : #ViennaFloorNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaFloorNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'floor'
]

{ #category : #testing }
ViennaFloorNode >> isViennaFloorNode [

	^ true
]

{ #category : #accessing }
ViennaFloorNode >> label [

	^ 'Floor'
]

{ #category : #'pretty printing' }
ViennaFloorNode >> operatorPrecedence [

	^ 36
]
