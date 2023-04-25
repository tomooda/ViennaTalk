Class {
	#name : #ViennaSectionNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaSectionNode class >> isAbstract [

	^ self = ViennaSectionNode
]
