Class {
	#name : #ViennaDefinitionComponentNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaDefinitionComponentNode class >> isAbstract [

	^ self = ViennaDefinitionComponentNode
]
