Class {
	#name : #ViennaErrorStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaErrorStatementNode >> formatWith: aViennaAbstractFormatter [

	^ 'error'
]

{ #category : #testing }
ViennaErrorStatementNode >> isViennaErrorNode [

	^ true
]

{ #category : #accessing }
ViennaErrorStatementNode >> label [

	^ 'ErrorStatement'
]
