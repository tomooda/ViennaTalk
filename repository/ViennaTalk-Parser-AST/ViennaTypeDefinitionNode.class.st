Class {
	#name : #ViennaTypeDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaTypeDefinitionNode >> definition [

	^ self at: 1
]

{ #category : #'as yet unclassified' }
ViennaTypeDefinitionNode >> isViennaTypeDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaTypeDefinitionNode >> label [

	^ 'TypeDefinition'
]
