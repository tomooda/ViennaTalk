Class {
	#name : #ViennaConstrainedType,
	#superclass : #ViennaType,
	#instVars : [
		'basetype',
		'invariant'
	],
	#category : 'ViennaTalk-Type-Core'
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

{ #category : #arithmetic }
ViennaConstrainedType >> inv: aBlock [
	^ self class with: basetype with: [ :v | (invariant value: v) and: [ aBlock value: v ] ]
]

{ #category : #accessing }
ViennaConstrainedType >> invariant [
	^ invariant
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

{ #category : #private }
ViennaConstrainedType >> setBasetype: aViennaType invariant: aBlock [
	basetype := aViennaType.
	invariant := aBlock
]
