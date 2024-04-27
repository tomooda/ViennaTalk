Class {
	#name : #ViennaTraceBindingDefinitionNode,
	#superclass : #ViennaTraceDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaTraceBindingDefinitionNode class >> isAbstract [

	^ self = ViennaTraceBindingDefinitionNode
]
