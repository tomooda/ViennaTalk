Class {
	#name : #ViennaRealType,
	#superclass : #ViennaType,
	#type : #variable,
	#classVars : [
		'Current'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaRealType class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ViennaRealType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaRealType >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #comparing }
ViennaRealType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isRealType ]
]

{ #category : #enumerating }
ViennaRealType >> do: aBlock [
	^ self shouldNotImplement
]

{ #category : #comparing }
ViennaRealType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaRealType >> includes: anObject [
	^ anObject isNumber
]

{ #category : #testing }
ViennaRealType >> isEnumerable [
	^ false
]

{ #category : #testing }
ViennaRealType >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaRealType >> name [
	^ 'real'
]
