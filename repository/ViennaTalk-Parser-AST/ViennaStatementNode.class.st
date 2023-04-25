Class {
	#name : #ViennaStatementNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaStatementNode class >> isAbstract [

	^ self = ViennaStatementNode
]
