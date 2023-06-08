Class {
	#name : #ViennaExplicitOperationDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaExplicitOperationDefinitionNode >> isViennaExplicitOperationDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> label [

	^ 'ExplicitOperationDefinition'
]
