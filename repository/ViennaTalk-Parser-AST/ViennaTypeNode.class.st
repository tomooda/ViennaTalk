Class {
	#name : #ViennaTypeNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTypeNode class >> isAbstract [

	^ self = ViennaTypeNode
]
