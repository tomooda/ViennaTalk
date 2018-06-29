Class {
	#name : #ViennaNat1Type,
	#superclass : #ViennaType,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaNat1Type class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaNat1Type >> = anObject [
	^ self class = anObject class or: [ self class = anObject ]
]

{ #category : #comparing }
ViennaNat1Type >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType isNat1Type ]
]

{ #category : #enumerating }
ViennaNat1Type >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaNat1Type >> basicIncludes: anObject [
	^ anObject isInteger and: [ anObject > 0 ]
]

{ #category : #testing }
ViennaNat1Type >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaNat1Type >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaNat1Type >> isIntType [
	^ true
]

{ #category : #testing }
ViennaNat1Type >> isNat1Type [
	^ true
]

{ #category : #testing }
ViennaNat1Type >> isNatType [
	^ true
]

{ #category : #testing }
ViennaNat1Type >> isRealType [
	^ true
]

{ #category : #accessing }
ViennaNat1Type >> name [
	^ 'nat1'
]
