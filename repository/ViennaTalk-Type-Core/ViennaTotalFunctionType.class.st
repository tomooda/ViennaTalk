Class {
	#name : #ViennaTotalFunctionType,
	#superclass : #ViennaType,
	#instVars : [
		'returntype',
		'argtypes'
	],
	#category : 'ViennaTalk-Type-Core'
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

{ #category : #comparing }
ViennaTotalFunctionType >> = anObject [
	^ self class = anObject class and: [ argtypes = anObject argtypes and: [ returntype = anObject returntype ] ]
]

{ #category : #comparing }
ViennaTotalFunctionType >> >= aViennaType [
	^ super >= aViennaType
		or: [ 
			aViennaType class = self class
				and: [ 
					argtypes size = aViennaType argtypes size
						and: [ 
							((1 to: argtypes size) allSatisfy: [ :i | (aViennaType argtypes at: i) >= (argtypes at: i) ])
								and: returntype >= aViennaType returntype ] ] ]
]

{ #category : #private }
ViennaTotalFunctionType >> argtypes [
	^ argtypes
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
ViennaTotalFunctionType >> name [
	^ ('*'
		join:
			(argtypes
				collect: [ :t | 
					t
						nameInPrecedence:
							(argtypes size = 1
								ifTrue: [ self class precedence + 1 ]
								ifFalse: [ ViennaProductType precedence ]) ])) , '+>' , (returntype nameInPrecedence: self class precedence)
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
