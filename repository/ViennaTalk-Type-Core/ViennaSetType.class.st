Class {
	#name : #ViennaSetType,
	#superclass : #ViennaType,
	#instVars : [
		'basetype'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaSetType class >> of: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #accessing }
ViennaSetType class >> precedence [
	^ 5
]

{ #category : #'instance creation' }
ViennaSetType class >> with: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #comparing }
ViennaSetType >> = anObject [
	^ self class = anObject class and: [ basetype = anObject basetype ]
]

{ #category : #comparing }
ViennaSetType >> >= aViennaType [
	^ super >= aViennaType
		or: [ (aViennaType class = self class or: [ aViennaType class = ViennaSet1Type ]) and: [ basetype >= aViennaType basetype ] ]
]

{ #category : #private }
ViennaSetType >> basetype [
	^ basetype
]

{ #category : #enumerating }
ViennaSetType >> basicDo: aBlock [
	| values |
	values := Array new: 1024 streamContents: [ :stream | basetype do: [ :v | stream nextPut: v ] ].
	values powerDo: [ :array | aBlock value: array asSet ]
]

{ #category : #testing }
ViennaSetType >> basicIncludes: anObject [
	^ anObject isSet and: [ anObject allSatisfy: [ :value | basetype includes: value ] ]
]

{ #category : #testing }
ViennaSetType >> basicIsEnumerable [
	^ basetype isEnumerable
]

{ #category : #comparing }
ViennaSetType >> hash [
	^ basetype hash bitXor: 16rffff
]

{ #category : #accessing }
ViennaSetType >> name [
	^ 'set of ' , (basetype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaSetType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetype := basetype removeTypeHolders: aSet
]

{ #category : #private }
ViennaSetType >> setBasetype: aViennaType [
	basetype := aViennaType
]
