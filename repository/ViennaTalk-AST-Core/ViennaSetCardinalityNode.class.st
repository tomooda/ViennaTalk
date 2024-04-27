Class {
	#name : #ViennaSetCardinalityNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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

{ #category : #typechecking }
ViennaSetCardinalityNode >> paramType [

	^ ViennaType any set
]

{ #category : #typechecking }
ViennaSetCardinalityNode >> returnTypeFor: aViennaType [

	^ aViennaType isSet1Type
		  ifTrue: [ ViennaType nat1 ]
		  ifFalse: [ ViennaType nat ]
]
