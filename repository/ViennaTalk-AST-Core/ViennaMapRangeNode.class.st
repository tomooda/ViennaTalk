Class {
	#name : #ViennaMapRangeNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaMapRangeNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'rng'
]

{ #category : #accessing }
ViennaMapRangeNode >> isViennaMapRangeNode [

	^ true
]

{ #category : #accessing }
ViennaMapRangeNode >> label [

	^ 'MapRange'
]

{ #category : #typechecking }
ViennaMapRangeNode >> maximalType: aViennaType [

	| valuetype |
	aViennaType isAnyType
		ifTrue: [ valuetype := ViennaType any ]
		ifFalse: [
			valuetype := ViennaType unit.
			aViennaType
				possibleTypesSuchThat: #isSetType
				do: [ :setType | valuetype := valuetype + setType basetype ] ].
	self expression maximalType: (ViennaType any mapTo: valuetype).
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaMapRangeNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaMapRangeNode >> paramType [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #typechecking }
ViennaMapRangeNode >> returnTypeFor: aViennaType [

	^ aViennaType valuetype set
]
