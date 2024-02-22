Class {
	#name : #ViennaInmapType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'keytype',
		'valuetype'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaInmapType class >> precedence [
	^ 4
]

{ #category : #'instance creation' }
ViennaInmapType class >> with: aViennaType1 with: aViennaType2 [
	^ self new
		setKeytype: aViennaType1 valuetype: aViennaType2;
		yourself
]

{ #category : #arithmetic }
ViennaInmapType >> & aViennaType [

	| ktype vtype |
	aViennaType isAnyType ifTrue: [ ^ self ].
	ktype := ViennaType unit.
	vtype := ViennaType unit.
	aViennaType possibleTypesDo: [ :type |
		type isMapType ifTrue: [
			ktype := ktype + type keytype.
			vtype := vtype + type valuetype ] ].
	ktype := ktype isAnyType
		         ifTrue: [ self keytype ]
		         ifFalse: [
			         self keytype isAnyType
				         ifTrue: [ ktype ]
				         ifFalse: [
				         ktype & self keytype ifUnit: [ ^ ViennaType unit ] ] ].
	vtype := vtype isAnyType
		         ifTrue: [ self valuetype ]
		         ifFalse: [
			         self valuetype isAnyType
				         ifTrue: [ vtype ]
				         ifFalse: [
				         vtype & self valuetype ifUnit: [ ^ ViennaType unit ] ] ].
	^ ktype inmapTo: vtype
]

{ #category : #comparing }
ViennaInmapType >> = anObject [
	^ self class = anObject class and: [ keytype = anObject keytype and: [ valuetype = anObject valuetype ] ]
]

{ #category : #comparing }
ViennaInmapType >> >= aViennaType [
	^ super >= aViennaType
		or: [ aViennaType class = self class and: [ keytype >= aViennaType keytype and: [ valuetype >= aViennaType valuetype ] ] ]
]

{ #category : #enumerating }
ViennaInmapType >> basicDo: aBlock [
	| values |
	values := Array
		new: 1024
		streamContents: [ :stream | keytype do: [ :k | valuetype do: [ :v | stream nextPut: k -> v ] ] ].
	values
		powerDo: [ :array | 
			| dict |
			dict := Dictionary new.
			array do: [ :assoc | dict at: assoc key put: assoc value ].
			dict values asSet size = array size
				ifTrue: [ aBlock value: dict ] ]
]

{ #category : #testing }
ViennaInmapType >> basicIncludes: anObject [
	^ anObject isDictionary
		and: [ 
			(anObject keys allSatisfy: [ :key | keytype includes: key ])
				and: [ (anObject values allSatisfy: [ :value | valuetype includes: value ]) and: [ anObject values asSet size = anObject size ] ] ]
]

{ #category : #testing }
ViennaInmapType >> basicIsEnumerable [
	^ keytype isEnumerable and: [ valuetype isEnumerable ]
]

{ #category : #comparing }
ViennaInmapType >> hash [
	^ keytype hash bitXor: valuetype hash
]

{ #category : #accessing }
ViennaInmapType >> instantiate: aDictionary [

	^ self class
		  with: (self keytype instantiate: aDictionary)
		  with: (self valuetype instantiate: aDictionary)
]

{ #category : #testing }
ViennaInmapType >> isCompatibleWith: aViennaType [

	^ (aViennaType isMapType and: [
		   (keytype isUnitType and: [ valuetype isUnitType ]) or: [
			   (aViennaType keytype isUnitType and: [
				    aViennaType valuetype isUnitType ]) or: [
				   (self keytype isAnyType or: [
					    aViennaType keytype isAnyType or: [
						    self keytype isCompatibleWith: aViennaType keytype ] ])
					   and: [
						   self valuetype isAnyType or: [
							   aViennaType valuetype isAnyType or: [
								   self valuetype isCompatibleWith: aViennaType valuetype ] ] ] ] ] ])
		  or: [ super isCompatibleWith: aViennaType ]
]

{ #category : #testing }
ViennaInmapType >> isInmapType [

	^ true
]

{ #category : #testing }
ViennaInmapType >> isMapType [

	^ true
]

{ #category : #private }
ViennaInmapType >> keytype [
	^ keytype
]

{ #category : #accessing }
ViennaInmapType >> name [
	^ 'inmap ' , (keytype nameInPrecedence: self class precedence) , ' to '
		, (valuetype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaInmapType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	keytype := keytype removeTypeHolders: aSet.
	valuetype := valuetype removeTypeHolders: aSet
]

{ #category : #private }
ViennaInmapType >> setKeytype: aViennaType1 valuetype: aViennaType2 [
	keytype := aViennaType1.
	valuetype := aViennaType2
]

{ #category : #private }
ViennaInmapType >> valuetype [
	^ valuetype
]
