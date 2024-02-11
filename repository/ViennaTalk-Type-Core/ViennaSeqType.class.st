Class {
	#name : #ViennaSeqType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'basetype'
	],
	#category : #'ViennaTalk-Type-Core'
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

{ #category : #arithmetic }
ViennaSeqType >> & aViennaType [

	^ aViennaType isSeq1Type
		  ifTrue: [ (basetype & aViennaType basetype) seq1 ]
		  ifFalse: [
			  aViennaType isSeqType
				  ifTrue: [ (basetype & aViennaType basetype) seq ]
				  ifFalse: [ ViennaType unit ] ]
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
ViennaSeqType >> instantiate: aDictionary [

	^ self class with: (self basetype instantiate: aDictionary)
]

{ #category : #testing }
ViennaSeqType >> isCompatibleWith: aViennaType [

	^ (aViennaType isSeqType and: [
		   basetype isCompatibleWith: aViennaType basetype ]) or: [
		  super isCompatibleWith: aViennaType ]
]

{ #category : #testing }
ViennaSeqType >> isSeqType [

	^ true
]

{ #category : #accessing }
ViennaSeqType >> name [
	^ 'seq of ' , (basetype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaSeqType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetype := basetype removeTypeHolders: aSet
]

{ #category : #private }
ViennaSeqType >> setBasetype: aViennaType [
	basetype := aViennaType
]
