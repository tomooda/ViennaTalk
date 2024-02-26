Class {
	#name : #ViennaTraceBindingDefinitionNode,
	#superclass : #ViennaTraceDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTraceBindingDefinitionNode class >> isAbstract [

	^ self = ViennaTraceBindingDefinitionNode
]
