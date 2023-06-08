Class {
	#name : #ViennaImplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaImplicitFunctionDefinitionNode >> isViennaImplicitFunctionDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaImplicitFunctionDefinitionNode >> label [

	^ 'ImplicitFunctionDefinition'
]
