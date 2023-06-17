Class {
	#name : #ViennaStatementNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaStatementNode class >> isAbstract [

	^ self = ViennaStatementNode
]

{ #category : #testing }
ViennaStatementNode >> isViennaStatementNode [

	^ true
]
