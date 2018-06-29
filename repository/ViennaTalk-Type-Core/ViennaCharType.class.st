Class {
	#name : #ViennaCharType,
	#superclass : #ViennaType,
	#type : #variable,
	#classVars : [
		'Current'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaCharType class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ViennaCharType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaCharType >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #enumerating }
ViennaCharType >> do: aBlock [
	^ self shouldNotImplement
]

{ #category : #comparing }
ViennaCharType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaCharType >> includes: anObject [
	^ anObject isCharacter
]

{ #category : #testing }
ViennaCharType >> isEnumerable [
	^ false
]

{ #category : #accessing }
ViennaCharType >> name [
	^ 'char'
]
