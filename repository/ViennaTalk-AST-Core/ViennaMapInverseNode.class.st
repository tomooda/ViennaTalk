Class {
	#name : 'ViennaMapInverseNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaMapInverseNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ self shouldNotImplement
]

{ #category : 'pretty printing' }
ViennaMapInverseNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter inverse:
		  (aViennaAbstractFormatter format: self expression)
]

{ #category : 'testing' }
ViennaMapInverseNode >> isViennaMapInverseNode [

	^ true
]

{ #category : 'accessing' }
ViennaMapInverseNode >> label [

	^ 'MapInverse'
]

{ #category : 'typechecking' }
ViennaMapInverseNode >> maximalType: aViennaType [

	| keytype valuetype |
	keytype := ViennaType unit.
	valuetype := ViennaType unit.
	aViennaType isAnyType
		ifTrue: [ keytype := valuetype := ViennaType any ]
		ifFalse: [
			aViennaType possibleTypesSuchThat: #isMapType do: [ :mapType |
				keytype := keytype + mapType keytype.
				valuetype := valuetype + mapType valuetype ] ].
	self expression maximalType: (valuetype mapTo: keytype).
	super maximalType: aViennaType
]

{ #category : 'pretty printing' }
ViennaMapInverseNode >> operatorPrecedence [

	^ 33
]

{ #category : 'typechecking' }
ViennaMapInverseNode >> paramType [

	^ ViennaType any inmapTo: ViennaType any
]

{ #category : 'typechecking' }
ViennaMapInverseNode >> returnTypeFor: aViennaType [

	| keytype valuetype |
	aViennaType isAnyType
		ifTrue: [ keytype := valuetype := ViennaType any ]
		ifFalse: [
			keytype := ViennaType unit.
			valuetype := ViennaType unit.
			aViennaType possibleTypesSuchThat: #isMapType do: [ :mapType |
				keytype := keytype + mapType keytype.
				valuetype := valuetype + mapType valuetype ] ].
	^ aViennaType isInmapType
		  ifTrue: [ valuetype inmapTo: keytype ]
		  ifFalse: [ ViennaType unit ]
]
