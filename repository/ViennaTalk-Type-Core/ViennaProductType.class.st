Class {
	#name : #ViennaProductType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'basetypes'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaProductType class >> precedence [
	^ 3
]

{ #category : #'instance creation' }
ViennaProductType class >> with: aViennaType1 with: aViennaType2 [
	^ self withAll: (Array with: aViennaType1 with: aViennaType2)
]

{ #category : #'instance creation' }
ViennaProductType class >> withAll: anArrayOfViennaType [
	^ self new
		setBasetypes: anArrayOfViennaType;
		yourself
]

{ #category : #arithmetic }
ViennaProductType >> * aViennaType [
	^ self copy setBasetypes: (basetypes copyWith: aViennaType)
]

{ #category : #arithmetic }
ViennaProductType >> +> aViennaType [
	^ ViennaTotalFunctionType withAll: basetypes with: aViennaType
]

{ #category : #arithmetic }
ViennaProductType >> -> aViennaType [
	^ ViennaPartialFunctionType withAll: basetypes with: aViennaType
]

{ #category : #comparing }
ViennaProductType >> = anObject [
	^ self class = anObject class and: [ basetypes = anObject basetypes ]
]

{ #category : #arithmetic }
ViennaProductType >> ==> aViennaType [
	^ ViennaOperationType withAll: basetypes with: aViennaType
]

{ #category : #private }
ViennaProductType >> basetypes [
	^ basetypes
]

{ #category : #enumerating }
ViennaProductType >> basicDo: aBlock [
	| blockGenerator block |
	blockGenerator := [ :outerCollection :b | [ :v | outerCollection do: [ :outerValue | b value: (v copyWith: outerValue) ] ] ].
	block := blockGenerator value: basetypes last value: aBlock.
	basetypes size - 1 to: 2 by: -1 do: [ :index | block := blockGenerator value: (basetypes at: index) value: block ].
	basetypes first do: [ :v | block value: (Array with: v) ]
]

{ #category : #testing }
ViennaProductType >> basicIncludes: anArray [
	^ anArray isArray
		and: [ 
			anArray size = basetypes size
				and: [ (1 to: basetypes size) allSatisfy: [ :index | (basetypes at: index) includes: (anArray at: index) ] ] ]
]

{ #category : #testing }
ViennaProductType >> basicIsEnumerable [
	^ basetypes allSatisfy: #isEnumerable
]

{ #category : #comparing }
ViennaProductType >> hash [
	^ basetypes hash
]

{ #category : #testing }
ViennaProductType >> isCompatibleWith: aViennaType [

	^ (aViennaType isProductType and: [
		   self basetypes size = aViennaType basetypes size and: [
			   (1 to: self basetypes size) allSatisfy: [ :i |
				   (self basetypes at: i) isCompatibleWith:
					   (aViennaType basetypes at: i) ] ] ]) or: [
		  super isCompatibleWith: aViennaType ]
]

{ #category : #testing }
ViennaProductType >> isProductType [

	^ true
]

{ #category : #accessing }
ViennaProductType >> name [
	^ '*' join: (basetypes collect: [ :t | t nameInPrecedence: self class precedence ])
]

{ #category : #private }
ViennaProductType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetypes := basetypes collect: [ :type | type removeTypeHolders: aSet ]
]

{ #category : #private }
ViennaProductType >> setBasetypes: anArrayOfViennaType [
	basetypes := anArrayOfViennaType
]
