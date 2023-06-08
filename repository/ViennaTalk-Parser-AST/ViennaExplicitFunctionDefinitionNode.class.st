Class {
	#name : #ViennaExplicitFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaExplicitFunctionDefinitionNode >> isViennaExplicitFunctionDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> label [

	^ 'ExplicitFunctionDefinition'
]
