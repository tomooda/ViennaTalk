Class {
	#name : #ViennaPartialFunctionType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'returntype',
		'argtypes'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaPartialFunctionType class >> precedence [
	^ 4
]

{ #category : #'instance creation' }
ViennaPartialFunctionType class >> withAll: anArrayOfViennaType with: aViennaType [
	^ self new
		setArgtypes: anArrayOfViennaType returntype: aViennaType;
		yourself
]

{ #category : #arithmetic }
ViennaPartialFunctionType >> & aViennaType [

	aViennaType isAnyType ifTrue: [ ^ self ].
	(aViennaType isFunctionType and: [
		 self argtypes size = aViennaType argtypes size ]) ifTrue: [
		| types |
		types := (1 to: argtypes size) collect: [ :i |
			         (self argtypes at: i) & (aViennaType argtypes at: i) ].
		(types allSatisfy: #notUnitType) ifTrue: [
			self returntype & aViennaType returntype ifNotUnit: [ :type |
				^ ViennaType partialFunction: types to: type ] ] ].
	^ ViennaType unit
]

{ #category : #comparing }
ViennaPartialFunctionType >> = anObject [
	^ self class = anObject class and: [ argtypes = anObject argtypes and: [ returntype = anObject returntype ] ]
]

{ #category : #comparing }
ViennaPartialFunctionType >> >= aViennaType [

	^ super >= aViennaType or: [
		  (aViennaType class = self class or: [
			   aViennaType class = ViennaTotalFunctionType ]) and: [
			  argtypes size = aViennaType argtypes size and: [
				  ((1 to: argtypes size) allSatisfy: [ :i |
					   (argtypes at: i) >= (aViennaType argtypes at: i) ]) and:
					  returntype >= aViennaType returntype ] ] ]
]

{ #category : #private }
ViennaPartialFunctionType >> argtypes [
	^ argtypes
]

{ #category : #converting }
ViennaPartialFunctionType >> asPartialFunctionType [

	^ self
]

{ #category : #enumerating }
ViennaPartialFunctionType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaPartialFunctionType >> basicIncludes: anObject [
	^ anObject isFunction and: [ argtypes size = anObject numArgs ]
]

{ #category : #testing }
ViennaPartialFunctionType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaPartialFunctionType >> hash [
	^ argtypes hash bitXor: returntype hash
]

{ #category : #accessing }
ViennaPartialFunctionType >> instantiate: aDictionary [

	^ self class
		  withAll:
		  (self argtypes collect: [ :t | t instantiate: aDictionary ])
		  with: (self returntype instantiate: aDictionary)
]

{ #category : #testing }
ViennaPartialFunctionType >> isCompatibleWith: aViennaType [

	^ (aViennaType isFunctionType and: [
		   self argtypes size = aViennaType argtypes size and: [
			   ((1 to: self argtypes size) allSatisfy: [ :i |
				    (self argtypes at: i) isCompatibleWith:
					    (aViennaType argtypes at: i) ]) and: [
				   self returntype isCompatibleWith: aViennaType returntype ] ] ])
		  or: [ super isCompatibleWith: aViennaType ]
]

{ #category : #testing }
ViennaPartialFunctionType >> isFunctionType [

	^ true
]

{ #category : #accessing }
ViennaPartialFunctionType >> name [

	^ ('*' join:
		   ((argtypes ifEmpty: [ { ViennaType unit } ]) collect: [ :t |
			    t nameInPrecedence: (argtypes size = 1
					     ifTrue: [ self class precedence + 1 ]
					     ifFalse: [ ViennaProductType precedence ]) ])) , '->'
	  , (returntype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaPartialFunctionType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	argtypes := argtypes collect: [ :type | type removeTypeHolders: aSet ].
	returntype := returntype removeTypeHolders: aSet 
]

{ #category : #private }
ViennaPartialFunctionType >> returntype [
	^ returntype
]

{ #category : #private }
ViennaPartialFunctionType >> setArgtypes: anArrayOfViennaType returntype: aViennaType [
	argtypes := anArrayOfViennaType.
	returntype := aViennaType
]
