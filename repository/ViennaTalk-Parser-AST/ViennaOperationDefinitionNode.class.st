Class {
	#name : #ViennaOperationDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaOperationDefinitionNode >> identifier [

	^ (self at: 1) identifier
]

{ #category : #'as yet unclassified' }
ViennaOperationDefinitionNode >> isViennaOperationDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaOperationDefinitionNode >> label [

	^ 'OperationDefinition'
]
