Class {
	#name : #ViennaIdentityStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaIdentityStatementNode >> formatWith: aViennaAbstractFormatter [

	^ 'skip'
]

{ #category : #testing }
ViennaIdentityStatementNode >> isViennaIdentityStatementNode [

	^ true
]

{ #category : #accessing }
ViennaIdentityStatementNode >> label [

	^ 'IdentityStatement'
]
