Class {
	#name : #ViennaUnionType,
	#superclass : #ViennaType,
	#instVars : [
		'basetypes'
	],
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaUnionType class >> either: aViennaType1 or: aViennaType2 [
	^ self withAll: (Array with: aViennaType1 with: aViennaType2)
]

{ #category : #accessing }
ViennaUnionType class >> precedence [
	^ 2
]

{ #category : #'instance creation' }
ViennaUnionType class >> with: aViennaType1 with: aViennaType2 [
	^ self withAll: (Array with: aViennaType1 with: aViennaType2)
]

{ #category : #'instance creation' }
ViennaUnionType class >> withAll: anArrayOfViennaType [
	^ self new
		setBasetypes: anArrayOfViennaType;
		yourself
]

{ #category : #comparing }
ViennaUnionType >> = anObject [
	^ self class = anObject class and: [ basetypes = anObject basetypes ]
]

{ #category : #comparing }
ViennaUnionType >> >= aViennaType [
	^ super >= aViennaType
		or: [ 
			aViennaType class = self class
				ifTrue: [ aViennaType basetypes allSatisfy: [ :t | self >= t ] ]
				ifFalse: [ basetypes anySatisfy: [ :t | t >= aViennaType ] ] ]
]

{ #category : #private }
ViennaUnionType >> basetypes [
	^ basetypes
]

{ #category : #enumerating }
ViennaUnionType >> basicDo: aBlock [
	basetypes do: [ :type | type do: aBlock ]
]

{ #category : #testing }
ViennaUnionType >> basicIncludes: anObject [
	^ basetypes anySatisfy: [ :type | type includes: anObject ]
]

{ #category : #testing }
ViennaUnionType >> basicIsEnumerable [
	^ basetypes allSatisfy: #isEnumerable
]

{ #category : #comparing }
ViennaUnionType >> hash [
	^ basetypes inject: 0 into: [ :h :t | h bitXor: t hash ]
]

{ #category : #accessing }
ViennaUnionType >> name [
	^ '|' join: (basetypes collect: [ :t | t nameInPrecedence: self class precedence ])
]

{ #category : #private }
ViennaUnionType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetypes := basetypes collect: [ :type | type removeTypeHolders: aSet ]
]

{ #category : #private }
ViennaUnionType >> setBasetypes: anArrayOfViennaType [
	basetypes := anArrayOfViennaType
]

{ #category : #arithmetic }
ViennaUnionType >> | aViennaType [
	^ self copy setBasetypes: (basetypes copyWith: aViennaType)
]
