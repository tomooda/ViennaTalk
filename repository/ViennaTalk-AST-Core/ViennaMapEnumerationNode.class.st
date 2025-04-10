Class {
	#name : 'ViennaMapEnumerationNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaMapEnumerationNode >> formatWith: aViennaAbstractFormatter [

	| elements |
	elements := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter empty ++ '{' ++ (aViennaAbstractFormatter
		   formatEnumerate: elements
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) ++ '}'
]

{ #category : 'private' }
ViennaMapEnumerationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :maplet | maplet freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'private' }
ViennaMapEnumerationNode >> isLiteralInmap [

	self do: [ :maplet |
		maplet valueExpression isViennaSymbolicLiteralNode ifFalse: [
			^ false ] ].
	^ (self collect: #valueExpression) asSet size = self size
]

{ #category : 'accessing' }
ViennaMapEnumerationNode >> isViennaMapEnumerationNode [

	^ true
]

{ #category : 'accessing' }
ViennaMapEnumerationNode >> label [

	^ 'MapEnumeration'
]

{ #category : 'typechecking' }
ViennaMapEnumerationNode >> maximalType [

	| keytype valuetype |
	maximalType ifNotNil: [ ^ maximalType ].
	keytype := ViennaType unit.
	valuetype := ViennaType unit.
	self do: [ :maplet |
		keytype := keytype + maplet keyExpression typecheck.
		valuetype := valuetype + maplet valueExpression typecheck ].
	^ self isLiteralInmap
		  ifTrue: [ keytype inmapTo: valuetype ]
		  ifFalse: [ keytype mapTo: valuetype ]
]

{ #category : 'typechecking' }
ViennaMapEnumerationNode >> maximalType: aViennaType [

	| keytype valuetype |
	keytype := ViennaType unit.
	valuetype := ViennaType unit.
	aViennaType isAnyType
		ifTrue: [ keytype := valuetype := ViennaType any ]
		ifFalse: [
			aViennaType possibleTypesSuchThat: #isMapType do: [ :mapType |
				keytype := keytype + mapType keytype.
				valuetype := valuetype + mapType valuetype ] ].
	self do: [ :maplet |
		maplet keyExpression maximalType: keytype.
		maplet valueExpression maximalType: valuetype ].
	super maximalType: aViennaType
]
