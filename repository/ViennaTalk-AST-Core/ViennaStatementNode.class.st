Class {
	#name : 'ViennaStatementNode',
	#superclass : 'ViennaNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaStatementNode class >> isAbstract [

	^ self = ViennaStatementNode
]

{ #category : 'private' }
ViennaStatementNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'testing' }
ViennaStatementNode >> isViennaStatementNode [

	^ true
]
