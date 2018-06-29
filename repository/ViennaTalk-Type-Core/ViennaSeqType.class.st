Class {
	#name : #ViennaSeqType,
	#superclass : #ViennaType,
	#instVars : [
		'basetype'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaSeqType class >> of: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #accessing }
ViennaSeqType class >> precedence [
	^ 5
]

{ #category : #'instance creation' }
ViennaSeqType class >> with: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #comparing }
ViennaSeqType >> = anObject [
	^ self class = anObject class and: [ basetype = anObject basetype ]
]

{ #category : #comparing }
ViennaSeqType >> >= aViennaType [
	^ super >= aViennaType
		or: [ (aViennaType class = self class or: [ aViennaType class = ViennaSeq1Type ]) and: [ basetype >= aViennaType basetype ] ]
]

{ #category : #private }
ViennaSeqType >> basetype [
	^ basetype
]

{ #category : #enumerating }
ViennaSeqType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaSeqType >> basicIncludes: anObject [
	^ anObject isSequence and: [ anObject allSatisfy: [ :value | basetype includes: value ] ]
]

{ #category : #testing }
ViennaSeqType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaSeqType >> hash [
	^ basetype hash bitXor: 16rffff
]

{ #category : #accessing }
ViennaSeqType >> name [
	^ 'seq of ' , (basetype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaSeqType >> setBasetype: aViennaType [
	basetype := aViennaType
]
