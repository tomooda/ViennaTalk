Class {
	#name : #ViennaDefinitionBlockNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaDefinitionBlockNode >> label [

	^ 'DefinitionBlock'
]

{ #category : #accessing }
ViennaDefinitionBlockNode >> section [
	^ self at: 1
]
