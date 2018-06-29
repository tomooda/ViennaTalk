Class {
	#name : #ViennaBoolType,
	#superclass : #ViennaType,
	#type : #variable,
	#classVars : [
		'Current'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaBoolType class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ViennaBoolType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaBoolType >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #enumerating }
ViennaBoolType >> do: aBlock [
	aBlock value: true.
	aBlock value: false
]

{ #category : #comparing }
ViennaBoolType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaBoolType >> includes: anObject [
	^ anObject = true or: [ anObject = false ]
]

{ #category : #testing }
ViennaBoolType >> isEnumerable [
	^ true
]

{ #category : #accessing }
ViennaBoolType >> name [
	^ 'bool'
]
