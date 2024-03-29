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
	valuetype := ViennaType unit.
	aViennaType
		possibleTypesSuchThat: #isMapType
		do: [ :mapType | valuetype := valuetype + mapType valuetype ].
	self expression maximalType: valuetype.
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
