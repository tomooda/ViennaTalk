Class {
	#name : #ViennaOperationType,
	#superclass : #ViennaCompoundType,
	#instVars : [
		'returntype',
		'argtypes'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaOperationType class >> precedence [
	^ 4
]

{ #category : #'instance creation' }
ViennaOperationType class >> withAll: anArrayOfViennaType with: aViennaType [
	^ self new
		setArgtypes: anArrayOfViennaType returntype: aViennaType;
		yourself
]

{ #category : #arithmetic }
ViennaOperationType >> & aViennaType [

	(aViennaType isOperationType and: [
		 self argtypes size = aViennaType argtypes size ]) ifTrue: [
		| types |
		types := (1 to: argtypes size) collect: [ :i |
			         (self argtypes at: i) & (aViennaType argtypes at: i) ].
		(types allSatisfy: #notUnitType) ifTrue: [
			(returntype isUnitType and: [ aViennaType returntype isUnitType ])
				ifTrue: [ ^ ViennaType operation: types to: ViennaType unit ].
			self returntype & aViennaType returntype ifNotUnit: [ :type |
				^ ViennaType operation: types to: type ] ] ].
	^ ViennaType unit
]

{ #category : #comparing }
ViennaOperationType >> = anObject [
	^ self class = anObject class and: [ argtypes = anObject argtypes and: [ returntype = anObject returntype ] ]
]

{ #category : #comparing }
ViennaOperationType >> >= aViennaType [

	^ super >= aViennaType or: [
		  aViennaType class = self class and: [
			  argtypes size = aViennaType argtypes size and: [
				  ((1 to: argtypes size) allSatisfy: [ :i |
					   (argtypes at: i) >= (aViennaType argtypes at: i) ]) and:
					  returntype >= aViennaType returntype ] ] ]
]

{ #category : #private }
ViennaOperationType >> argtypes [
	^ argtypes
]

{ #category : #enumerating }
ViennaOperationType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaOperationType >> basicIncludes: anObject [

	^ false
]

{ #category : #testing }
ViennaOperationType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaOperationType >> hash [
	^ argtypes hash bitXor: returntype hash
]

{ #category : #accessing }
ViennaOperationType >> instantiate: aDictionary [

	^ self class
		  withAll:
		  (self argtypes collect: [ :t | t instantiate: aDictionary ])
		  with: (self returntype instantiate: aDictionary)
]

{ #category : #testing }
ViennaOperationType >> isCompatibleWith: aViennaType [

	^ (aViennaType isOperationType and: [
		   self argtypes size = aViennaType argtypes size and: [
			   ((1 to: self argtypes size) allSatisfy: [ :i |
				    (self argtypes at: i) isCompatibleWith:
					    (aViennaType argtypes at: i) ]) and: [
				   self returntype isCompatibleWith: aViennaType returntype ] ] ])
		  or: [ super isCompatibleWith: aViennaType ]
]

{ #category : #testing }
ViennaOperationType >> isOperationType [

	^ true
]

{ #category : #accessing }
ViennaOperationType >> name [
	^ ('*'
		join:
			(argtypes
				collect: [ :t | 
					t
						nameInPrecedence:
							(argtypes size = 1
								ifTrue: [ self class precedence + 1 ]
								ifFalse: [ ViennaProductType precedence ]) ])) , '==>' , (returntype nameInPrecedence: self class precedence)
]

{ #category : #private }
ViennaOperationType >> removeTypeHolders: aSet [
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	argtypes := argtypes collect: [ :type | type removeTypeHolders: aSet ].
	returntype := returntype removeTypeHolders: aSet 
]

{ #category : #private }
ViennaOperationType >> returntype [
	^ returntype
]

{ #category : #private }
ViennaOperationType >> setArgtypes: anArrayOfViennaType returntype: aViennaType [
	argtypes := anArrayOfViennaType.
	returntype := aViennaType
]
