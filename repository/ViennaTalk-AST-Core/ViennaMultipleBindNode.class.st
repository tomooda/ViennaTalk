Class {
	#name : #ViennaMultipleBindNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaMultipleBindNode class >> isAbstract [

	^ self = ViennaMultipleBindNode
]

{ #category : #private }
ViennaMultipleBindNode >> boundIdentifiersDo: aBlock [

	self patternList boundIdentifiersDo: aBlock
]

{ #category : #testing }
ViennaMultipleBindNode >> isViennaMultipleBindNode [

	^ true
]

{ #category : #typechecking }
ViennaMultipleBindNode >> maximalType: aViennaType [

	self patternsDo: [ :pattern | pattern maximalType: aViennaType ].
	super maximalType: self maximalType
]

{ #category : #accessing }
ViennaMultipleBindNode >> patternList [

	^ self at: 1
]

{ #category : #accessing }
ViennaMultipleBindNode >> patternList: aViennaPatternListNode [

	self at: 1 put: aViennaPatternListNode
]

{ #category : #enumerating }
ViennaMultipleBindNode >> patternsDo: aBlock [

	self patternList do: aBlock
]
