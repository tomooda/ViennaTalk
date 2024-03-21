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
ViennaStatementNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #testing }
ViennaStatementNode >> isViennaStatementNode [

	^ true
]

{ #category : #accessing }
ViennaStatementNode >> parser [

	^ ViennaVDMParser new statement end
]
