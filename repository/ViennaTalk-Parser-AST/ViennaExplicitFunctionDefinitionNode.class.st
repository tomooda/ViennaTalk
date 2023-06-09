Class {
	#name : #ViennaExplicitFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #'as yet unclassified' }
ViennaExplicitFunctionDefinitionNode >> isViennaExplicitFunctionDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> label [

	^ 'ExplicitFunctionDefinition'
]
