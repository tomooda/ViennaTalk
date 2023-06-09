Class {
	#name : #ViennaImplicitOperationDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #'as yet unclassified' }
ViennaImplicitOperationDefinitionNode >> isViennaImplicitOperationDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaImplicitOperationDefinitionNode >> label [

	^ 'ImplicitOperationDefinition'
]
