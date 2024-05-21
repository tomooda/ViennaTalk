Class {
	#name : 'ViennaIdentityStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaIdentityStatementNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter keyword: 'skip'
]

{ #category : 'private' }
ViennaIdentityStatementNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : 'testing' }
ViennaIdentityStatementNode >> isViennaIdentityStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaIdentityStatementNode >> label [

	^ 'IdentityStatement'
]

{ #category : 'typechecking' }
ViennaIdentityStatementNode >> maximalType [

	^ ViennaType unit
]
