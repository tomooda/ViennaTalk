Class {
	#name : #ViennaPatternBindNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaPatternBindNode class >> isAbstract [

	^ self = ViennaPatternBindNode
]

{ #category : #private }
ViennaPatternBindNode >> boundIdentifiersDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #testing }
ViennaPatternBindNode >> isViennaPatternBindNode [

	^ true
]

{ #category : #testing }
ViennaPatternBindNode >> isViennaPatternHolderNode [

	^ true
]
