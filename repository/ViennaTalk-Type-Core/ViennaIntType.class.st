Class {
	#name : #ViennaIntType,
	#superclass : #ViennaType,
	#type : #variable,
	#classVars : [
		'Current'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaIntType class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ViennaIntType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaIntType >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #comparing }
ViennaIntType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isIntType ]
]

{ #category : #enumerating }
ViennaIntType >> do: aBlock [
	^ self shouldNotImplement
]

{ #category : #comparing }
ViennaIntType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaIntType >> includes: anObject [
	^ anObject isInteger
]

{ #category : #testing }
ViennaIntType >> isEnumerable [
	^ false
]

{ #category : #testing }
ViennaIntType >> isIntType [
	^ true
]

{ #category : #testing }
ViennaIntType >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaIntType >> name [
	^ 'int'
]