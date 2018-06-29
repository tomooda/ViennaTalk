Class {
	#name : #ViennaUnionType,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'basetypes'
	],
	#category : 'ViennaTalk-Type-Core'
}

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

{ #category : #private }
ViennaUnionType >> basetypes [
	^ basetypes
]

{ #category : #enumerating }
ViennaUnionType >> do: aBlock [
	basetypes do: [ :type | type do: aBlock ]
]

{ #category : #comparing }
ViennaUnionType >> hash [
	^ basetypes inject: 0 into: [ :h :t | h bitXor: t hash ]
]

{ #category : #testing }
ViennaUnionType >> includes: anObject [
	^ basetypes anySatisfy: [ :type | type includes: anObject ]
]

{ #category : #testing }
ViennaUnionType >> isEnumerable [
	^ basetypes allSatisfy: #isEnumerable
]

{ #category : #accessing }
ViennaUnionType >> name [
	^ '|' join: (basetypes collect: [ :t | t nameInPrecedence: self class precedence ])
]

{ #category : #private }
ViennaUnionType >> setBasetypes: anArrayOfViennaType [
	basetypes := anArrayOfViennaType
]

{ #category : #arithmetic }
ViennaUnionType >> | aViennaType [
	^ self copy setBasetypes: (basetypes copyWith: aViennaType)
]
