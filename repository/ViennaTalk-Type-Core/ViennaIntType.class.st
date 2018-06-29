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

{ #category : #accessing }
ViennaIntType >> name [
	^ 'int'
]

{ #category : #accessing }
ViennaIntType >> size [
	^ self shouldNotImplement
]
