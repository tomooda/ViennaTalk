Class {
	#name : #ViennaInterfaceComponentNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaInterfaceComponentNode class >> isAbstract [

	^ self = ViennaInterfaceComponentNode
]
