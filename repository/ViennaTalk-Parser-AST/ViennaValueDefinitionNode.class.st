Class {
	#name : #ViennaValueDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaValueDefinitionNode >> isViennaValueDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaValueDefinitionNode >> label [

	^ 'ValueDefinition'
]
