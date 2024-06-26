Class {
	#name : 'ViennaTypeNode',
	#superclass : 'ViennaNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaTypeNode class >> isAbstract [

	^ self = ViennaTypeNode
]

{ #category : 'converting' }
ViennaTypeNode >> asMaximalViennaType [

	^ self subclassResponsibility
]

{ #category : 'private' }
ViennaTypeNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'testing' }
ViennaTypeNode >> isViennaTypeNode [

	^ true
]

{ #category : 'typechecking' }
ViennaTypeNode >> maximalType [

	^ self asMaximalViennaType
]
