Class {
	#name : #ViennaCharType,
	#superclass : #ViennaType,
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
	^ self class = anObject class
]

{ #category : #enumerating }
ViennaCharType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaCharType >> basicIncludes: anObject [
	^ anObject isCharacter
]

{ #category : #testing }
ViennaCharType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaCharType >> hash [
	^ self class hash
]

{ #category : #accessing }
ViennaCharType >> name [
	^ 'char'
]
