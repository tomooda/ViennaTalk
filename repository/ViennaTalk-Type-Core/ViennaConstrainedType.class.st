Class {
	#name : #ViennaConstrainedType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'basetype',
		'invariant'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaConstrainedType class >> precedence [
	^ 0
]

{ #category : #'instance creation' }
ViennaConstrainedType class >> with: aViennaType with: aBlock [
	^ self new
		setBasetype: aViennaType invariant: aBlock;
		yourself
]

{ #category : #arithmetic }
ViennaConstrainedType >> & aViennaType [

	^ basetype & aViennaType ifNotUnit: [ :type | type inv: invariant ]
]

{ #category : #comparing }
ViennaConstrainedType >> = anObject [
	^ self class = anObject class and: [ basetype = anObject basetype and: [ invariant = anObject invariant ] ]
]

{ #category : #comparing }
ViennaConstrainedType >> >= aViennaType [
	^ false
]

{ #category : #'instance creation' }
ViennaConstrainedType >> applyTo: anArray [
	| value |
	value := basetype applyTo: anArray.
	^ (invariant value: value)
		ifTrue: [ value ]
		ifFalse: [ ViennaStateInvariantViolation signal ]
]

{ #category : #accessing }
ViennaConstrainedType >> basetype [
	^ basetype
]

{ #category : #enumerating }
ViennaConstrainedType >> basicDo: aBlock [
	basetype
		do: [ :v | 
			(invariant value: v)
				ifTrue: [ aBlock value: v ] ]
]

{ #category : #testing }
ViennaConstrainedType >> basicIncludes: anObject [
	^ (basetype includes: anObject) and: [ invariant value: anObject ]
]

{ #category : #testing }
ViennaConstrainedType >> basicIsEnumerable [
	^ basetype isEnumerable
]

{ #category : #comparing }
ViennaConstrainedType >> hash [
	^ basetype hash bitXor: invariant hash
]

{ #category : #accessing }
ViennaConstrainedType >> instantiate: aDictionary [

	^ self class
		  with: (self basetype instantiate: aDictionary)
		  with: self invariant
]

{ #category : #arithmetic }
ViennaConstrainedType >> inv: aBlock [
	^ self class with: basetype with: [ :v | (invariant value: v) and: [ aBlock value: v ] ]
]

{ #category : #accessing }
ViennaConstrainedType >> invariant [
	^ invariant
]

{ #category : #testing }
ViennaConstrainedType >> isCompatibleWith: aViennaType [

	^ basetype isCompatibleWith: aViennaType
]

{ #category : #testing }
ViennaConstrainedType >> isConstrainedType [

	^ true
]

{ #category : #testing }
ViennaConstrainedType >> isIntType [
	^ basetype isIntType
]

{ #category : #testing }
ViennaConstrainedType >> isNat1Type [
	^ basetype isNat1Type
]

{ #category : #testing }
ViennaConstrainedType >> isNatType [
	^ basetype isNatType
]

{ #category : #testing }
ViennaConstrainedType >> isRealType [
	^ basetype isRealType
]

{ #category : #accessing }
ViennaConstrainedType >> name [
	^ basetype name , ' inv ' , invariant printString
]

{ #category : #enumerating }
ViennaConstrainedType >> possibleTypesDo: aBlock [

	self basetype possibleTypesDo: aBlock
]

{ #category : #private }
ViennaConstrainedType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetype := basetype removeTypeHolders: aSet
]

{ #category : #private }
ViennaConstrainedType >> setBasetype: aViennaType invariant: aBlock [
	basetype := aViennaType.
	invariant := aBlock
]
