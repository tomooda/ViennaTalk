Class {
	#name : #ViennaTotalFunctionType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'returntype',
		'argtypes'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaTotalFunctionType class >> from: anArrayOfViennaType to: aViennaType [
	^ self new
		setArgtypes: anArrayOfViennaType returntype: aViennaType;
		yourself
]

{ #category : #accessing }
ViennaTotalFunctionType class >> precedence [
	^ 4
]

{ #category : #'instance creation' }
ViennaTotalFunctionType class >> withAll: anArrayOfViennaType with: aViennaType [
	^ self new
		setArgtypes: anArrayOfViennaType returntype: aViennaType;
		yourself
]

{ #category : #arithmetic }
ViennaTotalFunctionType >> & aViennaType [

	aViennaType isAnyType ifTrue: [ ^ self ].
	(aViennaType isFunctionType and: [
		 self argtypes size = aViennaType argtypes size ]) ifTrue: [
		| types |
		types := (1 to: argtypes size) collect: [ :i |
			         (self argtypes at: i) & (aViennaType argtypes at: i) ].
		(types allSatisfy: #notUnitType) ifTrue: [
			self returntype & aViennaType returntype ifNotUnit: [ :type |
				^ aViennaType isTotalFunctionType
					  ifTrue: [ ViennaType totalFunction: types to: type ]
					  ifFalse: [ ViennaType partialFunction: types to: type ] ] ] ].
	^ ViennaType unit
]

{ #category : #comparing }
ViennaTotalFunctionType >> = anObject [
	^ self class = anObject class and: [ argtypes = anObject argtypes and: [ returntype = anObject returntype ] ]
]

{ #category : #comparing }
ViennaTotalFunctionType >> >= aViennaType [

	^ super >= aViennaType or: [
		  aViennaType class = self class and: [
			  argtypes size = aViennaType argtypes size and: [
				  ((1 to: argtypes size) allSatisfy: [ :i |
					   (argtypes at: i) >= (aViennaType argtypes at: i) ]) and:
					  returntype >= aViennaType returntype ] ] ]
]

{ #category : #private }
ViennaTotalFunctionType >> argtypes [
	^ argtypes
]

{ #category : #converting }
ViennaTotalFunctionType >> asPartialFunctionType [

	^ ViennaPartialFunctionType
		  withAll: self argtypes
		  with: self returntype
]

{ #category : #enumerating }
ViennaTotalFunctionType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaTotalFunctionType >> basicIncludes: anObject [
	^ anObject isFunction and: [ argtypes size = anObject numArgs ]
]

{ #category : #testing }
ViennaTotalFunctionType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaTotalFunctionType >> hash [
	^ argtypes hash bitXor: returntype hash
]

{ #category : #accessing }
ViennaTotalFunctionType >> instantiate: aDictionary [

	^ self class
		  withAll:
		  (self argtypes collect: [ :t | t instantiate: aDictionary ])
		  with: (self returntype instantiate: aDictionary)
]

{ #category : #testing }
ViennaTotalFunctionType >> isCompatibleWith: aViennaType [

	^ (aViennaType isFunctionType and: [
		   self argtypes size = aViennaType argtypes size and: [
			   ((1 to: self argtypes size) allSatisfy: [ :i |
				    (self argtypes at: i) isCompatibleWith:
					    (aViennaType argtypes at: i) ]) and: [
				   self returntype isCompatibleWith: aViennaType returntype ] ] ])
		  or: [ super isCompatibleWith: aViennaType ]
]

{ #category : #testing }
ViennaTotalFunctionType >> isFunctionType [

	^ true
]

{ #category : #testing }
ViennaTotalFunctionType >> isTotalFunctionType [

	^ true
]

{ #category : #accessing }
ViennaTotalFunctionType >> name [

	^ ('*' join:
		   ((argtypes ifEmpty: [ { ViennaType unit } ]) collect: [ :t |
			    t nameInPrecedence: (argtypes size = 1
					     ifTrue: [ self class precedence + 1 ]
					     ifFalse: [ ViennaProductType precedence ]) ])) , '+>'
	  , (returntype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaTotalFunctionType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	argtypes := argtypes collect: [ :type | type removeTypeHolders: aSet ].
	returntype := returntype removeTypeHolders: aSet 
]

{ #category : #private }
ViennaTotalFunctionType >> returntype [
	^ returntype
]

{ #category : #private }
ViennaTotalFunctionType >> setArgtypes: anArrayOfViennaType returntype: aViennaType [
	argtypes := anArrayOfViennaType.
	returntype := aViennaType
]
