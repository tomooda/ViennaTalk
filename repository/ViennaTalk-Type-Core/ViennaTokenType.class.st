Class {
	#name : #ViennaTokenType,
	#superclass : #ViennaType,
	#type : #variable,
	#classVars : [
		'Current'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaTokenType class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ViennaTokenType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaTokenType >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #'instance creation' }
ViennaTokenType >> applyTo: anArray [
	^ anArray size = 1
		ifTrue: [ self value: anArray first ]
		ifFalse: [ self error: 'token accepts only one argument.' ]
]

{ #category : #enumerating }
ViennaTokenType >> do: aBlock [
	^ self shouldNotImplement
]

{ #category : #comparing }
ViennaTokenType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaTokenType >> includes: anObject [
	^ anObject isKindOf: ViennaToken
]

{ #category : #testing }
ViennaTokenType >> isEnumerable [
	^ false
]

{ #category : #accessing }
ViennaTokenType >> name [
	^ 'token'
]

{ #category : #'instance creation' }
ViennaTokenType >> value: anObject [
	^ ViennaToken with: anObject
]
