Class {
	#name : #ViennaOperationType,
	#superclass : #ViennaType,
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
					   (aViennaType argtypes at: i) >= (argtypes at: i) ]) and:
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
