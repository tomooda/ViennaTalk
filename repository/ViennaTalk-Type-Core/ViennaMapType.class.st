Class {
	#name : #ViennaMapType,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'keytype',
		'valuetype'
	],
	#category : 'ViennaTalk-Type-Core'
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
ViennaMapType >> do: aBlock [
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

{ #category : #comparing }
ViennaMapType >> hash [
	^ keytype hash bitXor: valuetype hash
]

{ #category : #testing }
ViennaMapType >> includes: anObject [
	^ anObject isDictionary
		and: [ 
			(anObject keys allSatisfy: [ :key | keytype includes: key ])
				and: [ anObject values allSatisfy: [ :value | valuetype includes: value ] ] ]
]

{ #category : #testing }
ViennaMapType >> isEnumerable [
	^ keytype isEnumerable and: [ valuetype isEnumerable ]
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
ViennaMapType >> setKeytype: aViennaType1 valuetype: aViennaType2 [
	keytype := aViennaType1.
	valuetype := aViennaType2
]

{ #category : #private }
ViennaMapType >> valuetype [
	^ valuetype
]
