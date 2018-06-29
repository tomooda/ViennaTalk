Class {
	#name : #ViennaAnyType,
	#superclass : #ViennaType,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #comparing }
ViennaAnyType >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
ViennaAnyType >> >= anObject [
	^ true
]

{ #category : #enumerating }
ViennaAnyType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaAnyType >> basicIncludes: anObject [
	^ true
]

{ #category : #testing }
ViennaAnyType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaAnyType >> hash [
	^ self class hash
]

{ #category : #accessing }
ViennaAnyType >> name [
	^ '?'
]
