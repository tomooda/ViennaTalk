Class {
	#name : #ViennaNatType,
	#superclass : #ViennaType,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaNatType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaNatType >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
ViennaNatType >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isNatType ]
]

{ #category : #enumerating }
ViennaNatType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaNatType >> basicIncludes: anObject [
	^ anObject isInteger and: [ anObject >= 0 ]
]

{ #category : #testing }
ViennaNatType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaNatType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaNatType >> isIntType [
	^ true
]

{ #category : #testing }
ViennaNatType >> isNatType [
	^ true
]

{ #category : #testing }
ViennaNatType >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaNatType >> name [
	^ 'nat'
]
