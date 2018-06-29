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

{ #category : #accessing }
ViennaRealType >> name [
	^ 'real'
]
