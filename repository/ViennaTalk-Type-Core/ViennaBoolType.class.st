Class {
	#name : #ViennaBoolType,
	#superclass : #ViennaType,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaBoolType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaBoolType >> = anObject [
	^ self class = anObject class
]

{ #category : #enumerating }
ViennaBoolType >> basicDo: aBlock [
	aBlock value: true.
	aBlock value: false
]

{ #category : #testing }
ViennaBoolType >> basicIncludes: anObject [
	^ anObject = true or: [ anObject = false ]
]

{ #category : #testing }
ViennaBoolType >> basicIsEnumerable [
	^ true
]

{ #category : #comparing }
ViennaBoolType >> hash [
	^ self class hash
]

{ #category : #accessing }
ViennaBoolType >> name [
	^ 'bool'
]
