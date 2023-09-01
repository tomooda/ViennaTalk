Class {
	#name : #ViennaTypeNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTypeNode class >> isAbstract [

	^ self = ViennaTypeNode
]

{ #category : #private }
ViennaTypeNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #testing }
ViennaTypeNode >> isViennaTypeNode [

	^ true
]
