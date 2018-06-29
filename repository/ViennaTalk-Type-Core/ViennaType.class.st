Class {
	#name : #ViennaType,
	#superclass : #Object,
	#type : #variable,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaType class >> bool [
	^ ViennaBoolType current
]

{ #category : #'instance creation' }
ViennaType class >> char [
	^ ViennaCharType current
]

{ #category : #'instance creation' }
ViennaType class >> compose: aString of: anArray [
	^ ViennaCompositeType constructorName: aString withAll: anArray
]

{ #category : #'instance creation' }
ViennaType class >> inmap: aViennaType1 to: aViennaType2 [
	^ ViennaInmapType with: aViennaType1 with: aViennaType2
]

{ #category : #'instance creation' }
ViennaType class >> int [
	^ ViennaIntType current
]

{ #category : #'instance creation' }
ViennaType class >> map: aViennaType1 to: aViennaType2 [
	^ ViennaMapType with: aViennaType1 with: aViennaType2
]

{ #category : #'instance creation' }
ViennaType class >> nat [
	^ ViennaNatType current
]

{ #category : #'instance creation' }
ViennaType class >> nat1 [
	^ ViennaNat1Type current
]

{ #category : #'instance creation' }
ViennaType class >> option: aViennaType [
	^ ViennaOptionType with: aViennaType
]

{ #category : #'instance creation' }
ViennaType class >> partialFunction: anArrayOfViennaType to: aViennaType [
	^ ViennaPartialFunctionType withAll: anArrayOfViennaType with: aViennaType
]

{ #category : #accessing }
ViennaType class >> precedence [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
ViennaType class >> product: anArrayOfViennaType [
	^ ViennaProductType withAll: anArrayOfViennaType
]

{ #category : #'instance creation' }
ViennaType class >> quote: aString [
	^ ViennaQuoteType with: aString asSymbol
]

{ #category : #'instance creation' }
ViennaType class >> rat [
	^ ViennaRealType current
]

{ #category : #'instance creation' }
ViennaType class >> real [
	^ ViennaRealType current
]

{ #category : #'instance creation' }
ViennaType class >> seq1Of: aViennaType [
	^ ViennaSeq1Type with: aViennaType
]

{ #category : #'instance creation' }
ViennaType class >> seqOf: aViennaType [
	^ ViennaSeqType with: aViennaType
]

{ #category : #'instance creation' }
ViennaType class >> set1Of: aViennaType [
	^ ViennaSet1Type with: aViennaType
]

{ #category : #'instance creation' }
ViennaType class >> setOf: aViennaType [
	^ ViennaSetType with: aViennaType
]

{ #category : #'instance creation' }
ViennaType class >> token [
	^ ViennaTokenType
]

{ #category : #'instance creation' }
ViennaType class >> totalFunction: anArrayOfViennaType to: aViennaType [
	^ ViennaTotalFunctionType withAll: anArrayOfViennaType with: aViennaType
]

{ #category : #'instance creation' }
ViennaType class >> union: anArrayOfViennaType [
	^ ViennaUnionType withAll: anArrayOfViennaType
]

{ #category : #arithmetic }
ViennaType >> * aViennaType [
	^ ViennaProductType with: self with: aViennaType
]

{ #category : #arithmetic }
ViennaType >> +> aViennaType [
	^ ViennaTotalFunctionType withAll: (Array with: self) with: aViennaType
]

{ #category : #arithmetic }
ViennaType >> -> aViennaType [
	^ ViennaPartialFunctionType withAll: (Array with: self) with: aViennaType
]

{ #category : #comparing }
ViennaType >> < aViennaType [
	^ self ~= aViennaType and: [ aViennaType >= self ]
]

{ #category : #comparing }
ViennaType >> <= aViennaType [
	^ aViennaType >= self
]

{ #category : #comparing }
ViennaType >> > aViennaType [
	^ self ~= aViennaType and: [ self >= aViennaType ]
]

{ #category : #comparing }
ViennaType >> >= aViennaType [
	^ self = aViennaType or: [ (aViennaType isKindOf: ViennaConstrainedType) and: [ self >= aViennaType basetype ] ]
]

{ #category : #enumerating }
ViennaType >> allSatisfy: aBlock [
	self
		do: [ :value | 
			(aBlock value: value)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #enumerating }
ViennaType >> anySatisfy: aBlock [
	self
		do: [ :value | 
			(aBlock value: value)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #enumerating }
ViennaType >> collect: aBlock [
	^ Array new: 4 streamContents: [ :stream | self do: [ :value | stream nextPut: (aBlock value: value) ] ]
]

{ #category : #enumerating }
ViennaType >> detect: aBlock [
	self
		do: [ :value | 
			(aBlock value: value)
				ifTrue: [ ^ value ] ].
	^ NotFound signal
]

{ #category : #enumerating }
ViennaType >> do: aBlock [
	^ self subclassResponsibility
]

{ #category : #testing }
ViennaType >> includes: anObject [
	^ self subclassResponsibility
]

{ #category : #arithmetic }
ViennaType >> inmapTo: aViennaType [
	^ ViennaInmapType with: self with: aViennaType
]

{ #category : #arithmetic }
ViennaType >> inv: aBlock [
	^ ViennaConstrainedType with: self with: aBlock
]

{ #category : #testing }
ViennaType >> isEnumerable [
	^ self subclassResponsibility
]

{ #category : #testing }
ViennaType >> isIntType [
	^ false
]

{ #category : #testing }
ViennaType >> isNat1Type [
	^ false
]

{ #category : #testing }
ViennaType >> isNatType [
	^ false
]

{ #category : #testing }
ViennaType >> isRealType [
	^ false
]

{ #category : #arithmetic }
ViennaType >> mapTo: aViennaType [
	^ ViennaMapType with: self with: aViennaType
]

{ #category : #accessing }
ViennaType >> name [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaType >> nameInPrecedence: anInteger [
	^ self class precedence < anInteger
		ifTrue: [ '(' , self name , ')' ]
		ifFalse: [ self name ]
]

{ #category : #enumerating }
ViennaType >> onlyOneSatisfy: aBlock [
	"Evaluate aBlock with the elements of the receiver.
	If aBlock returns true for the only one element return true.
	Otherwise return false."

	| found |
	found := false.
	self
		do: [ :each | 
			(aBlock value: each)
				ifTrue: [ 
					found
						ifTrue: [ ^ false ].
					found := true ] ].
	^ found
]

{ #category : #arithmetic }
ViennaType >> optional [
	^ ViennaOptionType with: self
]

{ #category : #printing }
ViennaType >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #enumerating }
ViennaType >> select: aBlock [
	^ Array
		new: 4
		streamContents: [ :stream | 
			self
				do: [ :value | 
					(aBlock value: value)
						ifTrue: [ stream nextPut: value ] ] ]
]

{ #category : #arithmetic }
ViennaType >> seq [
	^ ViennaSeqType with: self
]

{ #category : #arithmetic }
ViennaType >> seq1 [
	^ ViennaSeq1Type with: self
]

{ #category : #arithmetic }
ViennaType >> set [
	^ ViennaSetType with: self
]

{ #category : #arithmetic }
ViennaType >> set1 [
	^ ViennaSet1Type with: self
]

{ #category : #arithmetic }
ViennaType >> | aViennaType [
	^ ViennaUnionType with: self with: aViennaType
]
