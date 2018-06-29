Class {
	#name : #ViennaIntType,
	#superclass : #ViennaType,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaIntType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaIntType >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
ViennaIntType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isIntType ]
]

{ #category : #enumerating }
ViennaIntType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaIntType >> basicIncludes: anObject [
	^ anObject isInteger
]

{ #category : #testing }
ViennaIntType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaIntType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaIntType >> isIntType [
	^ true
]

{ #category : #testing }
ViennaIntType >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaIntType >> name [
	^ 'int'
]
