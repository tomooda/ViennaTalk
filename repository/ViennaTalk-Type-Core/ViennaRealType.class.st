Class {
	#name : #ViennaRealType,
	#superclass : #ViennaType,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaRealType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaRealType >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #comparing }
ViennaRealType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isRealType ]
]

{ #category : #enumerating }
ViennaRealType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaRealType >> basicIncludes: anObject [
	^ anObject isNumber
]

{ #category : #testing }
ViennaRealType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaRealType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaRealType >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaRealType >> name [
	^ 'real'
]
