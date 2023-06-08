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

{ #category : #'as yet unclassified' }
ViennaInterfaceComponentNode >> isViennaInterfaceComponentNode [

	^ true
]
