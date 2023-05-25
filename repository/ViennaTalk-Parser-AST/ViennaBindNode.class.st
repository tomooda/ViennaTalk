Class {
	#name : #ViennaBindNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaBindNode >> pattern [

	^ self at: 1
]
