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

{ #category : #private }
ViennaIdentityStatementNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #testing }
ViennaIdentityStatementNode >> isViennaIdentityStatementNode [

	^ true
]

{ #category : #accessing }
ViennaIdentityStatementNode >> label [

	^ 'IdentityStatement'
]
