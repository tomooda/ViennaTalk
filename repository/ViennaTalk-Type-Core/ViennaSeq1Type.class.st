Class {
	#name : #ViennaSeq1Type,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'basetype'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaSeq1Type class >> of: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #accessing }
ViennaSeq1Type class >> precedence [
	^ 5
]

{ #category : #'instance creation' }
ViennaSeq1Type class >> with: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #arithmetic }
ViennaSeq1Type >> & aViennaType [

	^ aViennaType isSeqType
		  ifTrue: [ (basetype & aViennaType basetype) seq1 ]
		  ifFalse: [ ViennaType unit ]
]

{ #category : #comparing }
ViennaSeq1Type >> = anObject [
	^ self class = anObject class and: [ basetype = anObject basetype ]
]

{ #category : #comparing }
ViennaSeq1Type >> >= aViennaType [
	^ super >= aViennaType or: [ aViennaType class = self class and: [ basetype >= aViennaType basetype ] ]
]

{ #category : #private }
ViennaSeq1Type >> basetype [
	^ basetype
]

{ #category : #enumerating }
ViennaSeq1Type >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaSeq1Type >> basicIncludes: anObject [
	^ anObject isSequence and: [ anObject notEmpty and: [ anObject allSatisfy: [ :value | basetype includes: value ] ] ]
]

{ #category : #testing }
ViennaSeq1Type >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaSeq1Type >> hash [
	^ basetype hash bitXor: 16rffff
]

{ #category : #accessing }
ViennaSeq1Type >> instantiate: aDictionary [

	^ self class with: (self basetype instantiate: aDictionary)
]

{ #category : #testing }
ViennaSeq1Type >> isCompatibleWith: aViennaType [

	^ (aViennaType isSeqType and: [
		   basetype isCompatibleWith: aViennaType basetype ]) or: [
		  super isCompatibleWith: aViennaType ]
]

{ #category : #testing }
ViennaSeq1Type >> isSeq1Type [

	^ true
]

{ #category : #testing }
ViennaSeq1Type >> isSeqType [

	^ true
]

{ #category : #accessing }
ViennaSeq1Type >> name [
	^ 'seq1 of ' , (basetype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaSeq1Type >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetype := basetype removeTypeHolders: aSet
]

{ #category : #private }
ViennaSeq1Type >> setBasetype: aViennaType [
	basetype := aViennaType
]
