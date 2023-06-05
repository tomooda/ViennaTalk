Class {
	#name : #ViennaDclStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaDclStatementNode >> isViennaDclStatementNode [

	^ true
]

{ #category : #accessing }
ViennaDclStatementNode >> label [

	^ 'DclStatement'
]
