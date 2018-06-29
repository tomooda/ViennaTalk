Class {
	#name : #ViennaSet1Type,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'basetype'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaSet1Type class >> of: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #accessing }
ViennaSet1Type class >> precedence [
	^ 5
]

{ #category : #'instance creation' }
ViennaSet1Type class >> with: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #comparing }
ViennaSet1Type >> = anObject [
	^ self class = anObject class and: [ basetype = anObject basetype ]
]

{ #category : #comparing }
ViennaSet1Type >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType class = self class and: [ basetype >= aViennaType basetype ] ]
]

{ #category : #private }
ViennaSet1Type >> basetype [
	^ basetype
]

{ #category : #enumerating }
ViennaSet1Type >> do: aBlock [
	| values |
	values := Array new: 1024 streamContents: [ :stream | basetype do: [ :v | stream nextPut: v ] ].
	values powerDo: [ :array | aBlock value: array asSet ]
]

{ #category : #comparing }
ViennaSet1Type >> hash [
	^ basetype hash bitXor: 16rffff
]

{ #category : #testing }
ViennaSet1Type >> includes: anObject [
	^ anObject isSet and: [ anObject notEmpty and: [ anObject allSatisfy: [ :value | basetype includes: value ] ] ]
]

{ #category : #testing }
ViennaSet1Type >> isEnumerable [
	^ basetype isEnumerable
]

{ #category : #accessing }
ViennaSet1Type >> name [
	^ 'set1 of ' , (basetype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaSet1Type >> setBasetype: aViennaType [
	basetype := aViennaType
]
