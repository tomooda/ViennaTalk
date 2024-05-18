Class {
	#name : 'ViennaBindNode',
	#superclass : 'ViennaPatternBindNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaBindNode class >> isAbstract [

	^ self = ViennaBindNode
]

{ #category : 'private' }
ViennaBindNode >> boundIdentifiersDo: aBlock [

	self pattern boundIdentifiersDo: aBlock
]

{ #category : 'testing' }
ViennaBindNode >> isViennaBindNode [

	^ true
]

{ #category : 'typechecking' }
ViennaBindNode >> maximalType: aViennaType [

	self pattern maximalType: aViennaType.
	super maximalType: self maximalType
]

{ #category : 'accessing' }
ViennaBindNode >> pattern [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaBindNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : 'accessing' }
ViennaBindNode >> typeOrExpression [

	^ self at: 2
]
