Class {
	#name : #ViennaNatType,
	#superclass : #ViennaType,
	#type : #variable,
	#classVars : [
		'Current'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaNatType class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ViennaNatType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaNatType >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #comparing }
ViennaNatType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isNatType ]
]

{ #category : #enumerating }
ViennaNatType >> do: aBlock [
	^ self shouldNotImplement
]

{ #category : #comparing }
ViennaNatType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaNatType >> includes: anObject [
	^ anObject isInteger and: [ anObject >= 0 ]
]

{ #category : #testing }
ViennaNatType >> isEnumerable [
	^ false
]

{ #category : #testing }
ViennaNatType >> isIntType [
	^ true
]

{ #category : #testing }
ViennaNatType >> isNatType [
	^ true
]

{ #category : #testing }
ViennaNatType >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaNatType >> name [
	^ 'nat'
]
