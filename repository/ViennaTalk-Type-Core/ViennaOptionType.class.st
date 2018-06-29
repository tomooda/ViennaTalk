Class {
	#name : #ViennaOptionType,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'basetype'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaOptionType class >> precedence [
	^ 6
]

{ #category : #'instance creation' }
ViennaOptionType class >> with: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #comparing }
ViennaOptionType >> = anObject [
	^ self class = anObject class and: [ basetype = anObject basetype ]
]

{ #category : #comparing }
ViennaOptionType >> >= aViennaType [
	^ super >= aViennaType or: [ basetype >= aViennaType ]
]

{ #category : #private }
ViennaOptionType >> basetype [
	^ basetype
]

{ #category : #enumerating }
ViennaOptionType >> do: aBlock [
	basetype do: aBlock.
	aBlock value: nil
]

{ #category : #comparing }
ViennaOptionType >> hash [
	^ basetype hash bitXor: 16rffff
]

{ #category : #testing }
ViennaOptionType >> includes: anObject [
	^ anObject isNil or: [ basetype includes: anObject ]
]

{ #category : #testing }
ViennaOptionType >> isEnumerable [
	^ basetype isEnumerable
]

{ #category : #accessing }
ViennaOptionType >> name [
	^ '[' , basetype name , ']'
]

{ #category : #arithmetic }
ViennaOptionType >> optional [
	^ self
]

{ #category : #private }
ViennaOptionType >> setBasetype: aViennaType [
	basetype := aViennaType
]
