Class {
	#name : #ViennaStateDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaStateDefinitionNode >> isViennaStateDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaStateDefinitionNode >> label [

	^ 'StateDefinition'
]
