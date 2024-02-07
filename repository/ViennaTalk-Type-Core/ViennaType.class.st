Class {
	#name : #ViennaType,
	#superclass : #Object,
	#instVars : [
		'runtimeSet'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaType class >> any [
	^ ViennaAnyType current
]

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
ViennaType class >> operation: anArrayOfViennaType to: aViennaType [
	^ ViennaOperationType withAll: anArrayOfViennaType with: aViennaType
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

	^ anArrayOfViennaType ifEmpty: [ self unit ] ifNotEmpty: [
		  anArrayOfViennaType size = 1
			  ifTrue: [ anArrayOfViennaType first ]
			  ifFalse: [ ViennaProductType withAll: anArrayOfViennaType ] ]
]

{ #category : #'instance creation' }
ViennaType class >> quote: aString [

	^ ViennaQuoteType with: aString asSymbol
]

{ #category : #'instance creation' }
ViennaType class >> rat [
	^ ViennaRatType current
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

	^ ViennaTokenType current
]

{ #category : #'instance creation' }
ViennaType class >> totalFunction: anArrayOfViennaType to: aViennaType [
	^ ViennaTotalFunctionType withAll: anArrayOfViennaType with: aViennaType
]

{ #category : #'instance creation' }
ViennaType class >> union: anArrayOfViennaType [

	^ anArrayOfViennaType ifEmpty: [ self unit ] ifNotEmpty: [
		  anArrayOfViennaType size = 1
			  ifTrue: [ anArrayOfViennaType first ]
			  ifFalse: [ ViennaUnionType withAll: anArrayOfViennaType ] ]
]

{ #category : #'instance creation' }
ViennaType class >> unit [

	^ ViennaUnitType current
]

{ #category : #arithmetic }
ViennaType >> * aViennaType [
	^ ViennaProductType with: self with: aViennaType
]

{ #category : #arithmetic }
ViennaType >> + aViennaType [

	^ (aViennaType isUnitType or: [ self >= aViennaType ])
		  ifTrue: [ self ]
		  ifFalse: [
			  aViennaType >= self
				  ifTrue: [ aViennaType ]
				  ifFalse: [
					  aViennaType isOptionType
						  ifTrue: [ (self + aViennaType basetype) optional ]
						  ifFalse: [ self | aViennaType ] ] ]
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

{ #category : #arithmetic }
ViennaType >> ==> aViennaType [
	^ ViennaOperationType withAll: (Array with: self) with: aViennaType
]

{ #category : #comparing }
ViennaType >> > aViennaType [
	^ self ~= aViennaType and: [ self >= aViennaType ]
]

{ #category : #comparing }
ViennaType >> >= aViennaType [

	^ self = aViennaType or: [
		  aViennaType isUnitType or: [
			  (aViennaType isKindOf: ViennaConstrainedType) and: [
				  self >= aViennaType basetype ] ] ]
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

{ #category : #converting }
ViennaType >> asTypeHolder [
	^ ViennaTypeHolder on: self
]

{ #category : #enumerating }
ViennaType >> basicDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #testing }
ViennaType >> basicIncludes: anObject [
	^ self subclassResponsibility
]

{ #category : #testing }
ViennaType >> basicIsEnumerable [
	^ self subclassResponsibility
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
ViennaType >> detect: aBlock ifNone: errorBlock [
	self
		do: [ :value | 
			(aBlock value: value)
				ifTrue: [ ^ value ] ].
	^ errorBlock value
]

{ #category : #enumerating }
ViennaType >> do: aBlock [
	runtimeSet ifNotNil: [ runtimeSet do: aBlock ] ifNil: [ self basicDo: aBlock ]
]

{ #category : #testing }
ViennaType >> includes: anObject [
	^ runtimeSet ifNotNil: [ runtimeSet includes: anObject ] ifNil: [ self basicIncludes: anObject ]
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
ViennaType >> isAnyType [

	^ false
]

{ #category : #testing }
ViennaType >> isChoiceType [

	^ self isOptionType or: [ self isUnionType ]
]

{ #category : #testing }
ViennaType >> isCompatibleWith: aViennaType [

	^ aViennaType isAnyType or: [
		  self = aViennaType or: [
			  (aViennaType isChoiceType or: [ aViennaType isConstrainedType ])
				  and: [ aViennaType isCompatibleWith: self ] ] ]
]

{ #category : #testing }
ViennaType >> isConstrainedType [

	^ false
]

{ #category : #testing }
ViennaType >> isEnumerable [
	^ runtimeSet notNil or: [ self basicIsEnumerable ]
]

{ #category : #testing }
ViennaType >> isFunctionType [

	^ false
]

{ #category : #testing }
ViennaType >> isIntType [
	^ false
]

{ #category : #testing }
ViennaType >> isMapType [

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
ViennaType >> isOperationType [

	^ false
]

{ #category : #testing }
ViennaType >> isOptionType [

	^ false
]

{ #category : #testing }
ViennaType >> isProductType [

	^ false
]

{ #category : #testing }
ViennaType >> isRealType [
	^ false
]

{ #category : #testing }
ViennaType >> isSeq1Type [

	^ false
]

{ #category : #testing }
ViennaType >> isSeqType [

	^ false
]

{ #category : #testing }
ViennaType >> isSet1Type [

	^ false
]

{ #category : #testing }
ViennaType >> isSetType [

	^ false
]

{ #category : #testing }
ViennaType >> isTypeHolder [
	^ false
]

{ #category : #testing }
ViennaType >> isUnionType [

	^ false
]

{ #category : #testing }
ViennaType >> isUnitType [

	^ false
]

{ #category : #arithmetic }
ViennaType >> mapTo: aViennaType [
	^ ViennaMapType with: self with: aViennaType
]

{ #category : #accessing }
ViennaType >> max [
	^ nil
]

{ #category : #accessing }
ViennaType >> max: aNumber [
	
]

{ #category : #accessing }
ViennaType >> min [
	^ nil
]

{ #category : #accessing }
ViennaType >> min: aNumber [
	
]

{ #category : #accessing }
ViennaType >> name [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaType >> nameInPrecedence: anInteger [
	^ self precedence < anInteger
		ifTrue: [ '(' , self shortName , ')' ]
		ifFalse: [ self shortName ]
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

{ #category : #accessing }
ViennaType >> possibleTypes [

	^ Array streamContents: [ :stream |
		  self possibleTypesDo: [ :type | stream nextPut: type ] ]
]

{ #category : #enumerating }
ViennaType >> possibleTypesDo: aBlock [

	aBlock value: self
]

{ #category : #enumerating }
ViennaType >> possibleTypesSuchThat: conditionBlock do: aBlock [

	self possibleTypesDo: [ :type |
		(conditionBlock value: type) ifTrue: [ aBlock value: type ] ]
]

{ #category : #accessing }
ViennaType >> precedence [
	^ self class precedence
]

{ #category : #printing }
ViennaType >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #private }
ViennaType >> removeTypeHolders [
	^ self removeTypeHolders: IdentitySet new
]

{ #category : #private }
ViennaType >> removeTypeHolders: aSet [
	aSet add: self.
	^ self
]

{ #category : #accessing }
ViennaType >> runtimeSet [
	^ runtimeSet
]

{ #category : #accessing }
ViennaType >> runtimeSet: aCollection [
	runtimeSet := aCollection
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

{ #category : #accessing }
ViennaType >> shortName [
	^ self name
]

{ #category : #arithmetic }
ViennaType >> | aViennaType [
	^ ViennaUnionType with: self with: aViennaType
]
