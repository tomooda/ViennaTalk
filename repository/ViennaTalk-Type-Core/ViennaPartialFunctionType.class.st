Class {
	#name : #ViennaPartialFunctionType,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'returntype',
		'argtypes'
	],
	#category : 'ViennaTalk-Type-Core'
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

{ #category : #comparing }
ViennaPartialFunctionType >> = anObject [
	^ self class = anObject class and: [ argtypes = anObject argtypes and: [ returntype = anObject returntype ] ]
]

{ #category : #comparing }
ViennaPartialFunctionType >> >= aViennaType [
	^ super >= aViennaType
		or: [ 
			(aViennaType class = self class or: [ aViennaType class = ViennaTotalFunctionType ])
				and: [ 
					argtypes size = aViennaType argtypes size
						and: [ 
							((1 to: argtypes size) allSatisfy: [ :i | (aViennaType argtypes at: i) >= (argtypes at: i) ])
								and: returntype >= aViennaType returntype ] ] ]
]

{ #category : #private }
ViennaPartialFunctionType >> argtypes [
	^ argtypes
]

{ #category : #enumerating }
ViennaPartialFunctionType >> do: aBlock [
	^ self shouldNotImplement
]

{ #category : #comparing }
ViennaPartialFunctionType >> hash [
	^ argtypes hash bitXor: returntype hash
]

{ #category : #testing }
ViennaPartialFunctionType >> includes: anObject [
	^ anObject isFunction and: [ argtypes size = anObject numArgs ]
]

{ #category : #testing }
ViennaPartialFunctionType >> isEnumerable [
	^ false
]

{ #category : #accessing }
ViennaPartialFunctionType >> name [
	^ ('*'
		join:
			(argtypes
				collect: [ :t | 
					t
						nameInPrecedence:
							(argtypes size = 1
								ifTrue: [ self class precedence + 1 ]
								ifFalse: [ ViennaProductType precedence ]) ])) , '->' , (returntype nameInPrecedence: self class precedence)
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
