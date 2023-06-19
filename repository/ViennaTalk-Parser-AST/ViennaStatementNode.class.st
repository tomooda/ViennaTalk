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

{ #category : #private }
ViennaStatementNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #testing }
ViennaStatementNode >> isViennaStatementNode [

	^ true
]
