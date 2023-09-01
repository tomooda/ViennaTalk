Class {
	#name : #ViennaDefinitionComponentNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaDefinitionComponentNode class >> isAbstract [

	^ self = ViennaDefinitionComponentNode
]

{ #category : #testing }
ViennaDefinitionComponentNode >> isViennaDefinitionComponentNode [

	^ true
]
