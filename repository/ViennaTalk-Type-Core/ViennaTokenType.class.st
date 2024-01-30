Class {
	#name : #ViennaTokenType,
	#superclass : #ViennaBasicType,
	#classVars : [
		'Current'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaTokenType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaTokenType >> = anObject [
	^ self class = anObject class
]

{ #category : #'instance creation' }
ViennaTokenType >> applyTo: anArray [
	^ anArray size = 1
		ifTrue: [ self value: anArray first ]
		ifFalse: [ self error: 'token accepts only one argument.' ]
]

{ #category : #enumerating }
ViennaTokenType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaTokenType >> basicIncludes: anObject [
	^ anObject isKindOf: ViennaToken
]

{ #category : #testing }
ViennaTokenType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaTokenType >> hash [
	^ self class hash
]

{ #category : #accessing }
ViennaTokenType >> name [
	^ 'token'
]

{ #category : #'instance creation' }
ViennaTokenType >> value: anObject [
	^ ViennaToken with: anObject
]
