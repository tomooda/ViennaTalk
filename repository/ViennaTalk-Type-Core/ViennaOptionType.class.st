Class {
	#name : #ViennaOptionType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'basetype'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaOptionType class >> precedence [
	^ 6
]

{ #category : #'instance creation' }
ViennaOptionType class >> with: aViennaType [
	^ self new
		setBasetype: aViennaType;
		yourself
]

{ #category : #arithmetic }
ViennaOptionType >> & aViennaType [

	^ aViennaType isAnyType
		  ifTrue: [ self ]
		  ifFalse: [
			  aViennaType isOptionType
				  ifTrue: [ (basetype & aViennaType basetype) optional ]
				  ifFalse: [ basetype & aViennaType ] ]
]

{ #category : #arithmetic }
ViennaOptionType >> + aViennaType [

	^ (self basetype + aViennaType) optional
]

{ #category : #comparing }
ViennaOptionType >> = anObject [
	^ self class = anObject class and: [ basetype = anObject basetype ]
]

{ #category : #comparing }
ViennaOptionType >> >= aViennaType [
	^ super >= aViennaType or: [ basetype >= aViennaType ]
]

{ #category : #private }
ViennaOptionType >> basetype [
	^ basetype
]

{ #category : #enumerating }
ViennaOptionType >> basicDo: aBlock [
	basetype do: aBlock.
	aBlock value: nil
]

{ #category : #testing }
ViennaOptionType >> basicIncludes: anObject [
	^ anObject isNil or: [ basetype includes: anObject ]
]

{ #category : #testing }
ViennaOptionType >> basicIsEnumerable [
	^ basetype isEnumerable
]

{ #category : #comparing }
ViennaOptionType >> hash [
	^ basetype hash bitXor: 16rffff
]

{ #category : #accessing }
ViennaOptionType >> instantiate: aDictionary [

	^ self class with: (self basetype instantiate: aDictionary)
]

{ #category : #testing }
ViennaOptionType >> isChoiceType [

	^ true
]

{ #category : #testing }
ViennaOptionType >> isCompatibleWith: aViennaType [

	^ aViennaType isOptionType or: [
		  (basetype isCompatibleWith: aViennaType) or: [
			  super isCompatibleWith: aViennaType ] ]
]

{ #category : #testing }
ViennaOptionType >> isOptionType [

	^ true
]

{ #category : #accessing }
ViennaOptionType >> name [

	^ '[' , basetype name , ']'
]

{ #category : #arithmetic }
ViennaOptionType >> optional [
	^ self
]

{ #category : #enumerating }
ViennaOptionType >> possibleTypesDo: aBlock [

	self basetype possibleTypesDo: aBlock.
	aBlock value: ViennaType unit optional
]

{ #category : #printing }
ViennaOptionType >> printOn: aStream [

	basetype isUnitType
		ifTrue: [ aStream nextPutAll: 'nil' ]
		ifFalse: [ super printOn: aStream ]
]

{ #category : #private }
ViennaOptionType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetype := basetype removeTypeHolders: aSet
]

{ #category : #private }
ViennaOptionType >> setBasetype: aViennaType [
	basetype := aViennaType
]
