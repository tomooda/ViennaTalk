Class {
	#name : #ViennaInmapType,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'keytype',
		'valuetype'
	],
	#category : 'ViennaTalk-Type-Core'
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
ViennaInmapType >> do: aBlock [
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

{ #category : #comparing }
ViennaInmapType >> hash [
	^ keytype hash bitXor: valuetype hash
]

{ #category : #testing }
ViennaInmapType >> includes: anObject [
	^ anObject isDictionary
		and: [ 
			(anObject keys allSatisfy: [ :key | keytype includes: key ])
				and: [ (anObject values allSatisfy: [ :value | valuetype includes: value ]) and: [ anObject values asSet size = anObject size ] ] ]
]

{ #category : #testing }
ViennaInmapType >> isEnumerable [
	^ keytype isEnumerable and: [ valuetype isEnumerable ]
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
ViennaInmapType >> setKeytype: aViennaType1 valuetype: aViennaType2 [
	keytype := aViennaType1.
	valuetype := aViennaType2
]

{ #category : #private }
ViennaInmapType >> valuetype [
	^ valuetype
]
