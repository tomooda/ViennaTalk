Class {
	#name : #ViennaOperationDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaOperationDefinitionNode >> definition [

	^ self at: 1
]

{ #category : #accessing }
ViennaOperationDefinitionNode >> identifier [

	^ self definition identifier
]

{ #category : #'as yet unclassified' }
ViennaOperationDefinitionNode >> isViennaOperationDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaOperationDefinitionNode >> label [

	^ 'OperationDefinition'
]
