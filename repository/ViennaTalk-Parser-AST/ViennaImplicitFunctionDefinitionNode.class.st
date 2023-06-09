Class {
	#name : #ViennaImplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #'as yet unclassified' }
ViennaImplicitFunctionDefinitionNode >> isViennaImplicitFunctionDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaImplicitFunctionDefinitionNode >> label [

	^ 'ImplicitFunctionDefinition'
]
