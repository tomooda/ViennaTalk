Class {
	#name : #ViennaNat1Type,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'Current'
	],
	#classVars : [
		'Current'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaNat1Type class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ViennaNat1Type class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaNat1Type >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #comparing }
ViennaNat1Type >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isNat1Type ]
]

{ #category : #enumerating }
ViennaNat1Type >> do: aBlock [
	^ self shouldNotImplement
]

{ #category : #comparing }
ViennaNat1Type >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaNat1Type >> includes: anObject [
	^ anObject isInteger and: [ anObject > 0 ]
]

{ #category : #testing }
ViennaNat1Type >> isEnumerable [
	^ false
]

{ #category : #testing }
ViennaNat1Type >> isIntType [
	^ true
]

{ #category : #testing }
ViennaNat1Type >> isNat1Type [
	^ true
]

{ #category : #testing }
ViennaNat1Type >> isNatType [
	^ true
]

{ #category : #testing }
ViennaNat1Type >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaNat1Type >> name [
	^ 'nat1'
]
