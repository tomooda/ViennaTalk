Class {
	#name : #ViennaMapType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'keytype',
		'valuetype'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaMapType class >> precedence [
	^ 4
]

{ #category : #'instance creation' }
ViennaMapType class >> with: aViennaType1 with: aViennaType2 [
	^ self new
		setKeytype: aViennaType1 valuetype: aViennaType2;
		yourself
]

{ #category : #arithmetic }
ViennaMapType >> & aViennaType [

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
	^ aViennaType isInmapType
		  ifTrue: [ ktype inmapTo: vtype ]
		  ifFalse: [ ktype mapTo: vtype ]
]

{ #category : #comparing }
ViennaMapType >> = anObject [
	^ self class = anObject class and: [ keytype = anObject keytype and: [ valuetype = anObject valuetype ] ]
]

{ #category : #comparing }
ViennaMapType >> >= aViennaType [
	^ super >= aViennaType
		or: [ 
			(aViennaType class = self class or: [ aViennaType class = ViennaInmapType ])
				and: [ keytype >= aViennaType keytype and: [ valuetype >= aViennaType valuetype ] ] ]
]

{ #category : #enumerating }
ViennaMapType >> basicDo: aBlock [
	| values |
	values := Array
		new: 1024
		streamContents: [ :stream | keytype do: [ :k | valuetype do: [ :v | stream nextPut: k -> v ] ] ].
	values
		powerDo: [ :array | 
			| dict |
			dict := Dictionary new.
			array do: [ :assoc | dict at: assoc key put: assoc value ].
			dict size = array size
				ifTrue: [ aBlock value: dict ] ]
]

{ #category : #testing }
ViennaMapType >> basicIncludes: anObject [
	^ anObject isDictionary
		and: [ 
			(anObject keys allSatisfy: [ :key | keytype includes: key ])
				and: [ anObject values allSatisfy: [ :value | valuetype includes: value ] ] ]
]

{ #category : #testing }
ViennaMapType >> basicIsEnumerable [
	^ keytype isEnumerable and: [ valuetype isEnumerable ]
]

{ #category : #comparing }
ViennaMapType >> hash [
	^ keytype hash bitXor: valuetype hash
]

{ #category : #accessing }
ViennaMapType >> instantiate: aDictionary [

	^ self class
		  with: (self keytype instantiate: aDictionary)
		  with: (self valuetype instantiate: aDictionary)
]

{ #category : #testing }
ViennaMapType >> isCompatibleWith: aViennaType [

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
ViennaMapType >> isMapType [

	^ true
]

{ #category : #private }
ViennaMapType >> keytype [
	^ keytype
]

{ #category : #accessing }
ViennaMapType >> name [
	^ 'map ' , (keytype nameInPrecedence: self class precedence) , ' to '
		, (valuetype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaMapType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	keytype := keytype removeTypeHolders: aSet.
	valuetype := valuetype removeTypeHolders: aSet
]

{ #category : #private }
ViennaMapType >> setKeytype: aViennaType1 valuetype: aViennaType2 [
	keytype := aViennaType1.
	valuetype := aViennaType2
]

{ #category : #private }
ViennaMapType >> valuetype [
	^ valuetype
]
