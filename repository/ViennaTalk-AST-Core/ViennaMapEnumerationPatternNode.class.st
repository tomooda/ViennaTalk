Class {
	#name : #ViennaMapEnumerationPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaMapEnumerationPatternNode >> boundIdentifiersDo: aBlock [

	self do: [ :mapletPattern |
		mapletPattern boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaMapEnumerationPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty , '{' , (aViennaAbstractFormatter
		   formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) , '}'
]

{ #category : #private }
ViennaMapEnumerationPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :mapletPattern |
		mapletPattern freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaMapEnumerationPatternNode >> isViennaMapEnumerationPatternNode [

	^ true
]

{ #category : #accessing }
ViennaMapEnumerationPatternNode >> label [

	^ 'MapEnumerationPattern'
]

{ #category : #typechecking }
ViennaMapEnumerationPatternNode >> maximalType [

	| keyType valueType |
	keyType := ViennaType unit.
	valueType := ViennaType unit.
	self do: [ :mapletPattern |
		mapletPattern typecheck possibleTypesDo: [ :type |
			type isMapType ifTrue: [
				keyType := keyType + type keytype.
				valueType := valueType + type valuetype ] ] ].
	^ keyType mapTo: valueType
]

{ #category : #typechecking }
ViennaMapEnumerationPatternNode >> maximalType: aViennaType [

	| keyType valueType mapType |
	keyType := ViennaType unit.
	valueType := ViennaType unit.
	aViennaType possibleTypesDo: [ :type |
		type isMapType ifTrue: [
			keyType := keyType + type keytype.
			valueType := valueType + type valuetype ] ].
	mapType := keyType mapTo: valueType.
	self do: [ :mapletPattern | mapletPattern maximalType: mapType ].
	super maximalType: self maximalType
]
