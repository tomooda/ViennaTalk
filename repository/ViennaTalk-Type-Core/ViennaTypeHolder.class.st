Class {
	#name : #ViennaTypeHolder,
	#superclass : #ViennaType,
	#instVars : [
		'type'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaTypeHolder class >> on: aViennaType [
	^ self new
		type: aViennaType;
		yourself
]

{ #category : #converting }
ViennaTypeHolder >> asTypeHolder [
	^ self
]

{ #category : #accessing }
ViennaTypeHolder >> name [
	^ type ifNil: [ '[]' ] ifNotNil: [ type name ]
]

{ #category : #accessing }
ViennaTypeHolder >> precedence [
	^ type ifNil: [ 0 ] ifNotNil: [ type precedence ]
]

{ #category : #private }
ViennaTypeHolder >> removeTypeHolders: aSet [
	^ type removeTypeHolders: aSet
]

{ #category : #accessing }
ViennaTypeHolder >> shortName [
	^ type ifNil: [ '[]' ] ifNotNil: [ type shortName ]
]

{ #category : #accessing }
ViennaTypeHolder >> type [
	^ type
]

{ #category : #accessing }
ViennaTypeHolder >> type: aViennaType [
	type := aViennaType
]
