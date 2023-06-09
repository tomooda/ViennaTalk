Class {
	#name : #ViennaFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaFunctionDefinitionNode >> identifier [

	^ (self at: 1) identifier
]

{ #category : #'as yet unclassified' }
ViennaFunctionDefinitionNode >> isViennaFunctionDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> label [

	^ 'FunctionDefinition'
]
