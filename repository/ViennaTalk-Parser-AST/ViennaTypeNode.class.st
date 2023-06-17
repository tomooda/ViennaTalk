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

{ #category : #testing }
ViennaTypeNode >> isViennaTypeNode [

	^ true
]
