Class {
	#name : #ViennaExtendedExplicitOperationDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #'as yet unclassified' }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaExtendedExplicitOperationDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> label [

	^ 'ExtendedExplicitOperationDefinition'
]
