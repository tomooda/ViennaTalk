Class {
	#name : #ViennaTraceRepeatDefinitionNode,
	#superclass : #ViennaTraceDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTraceRepeatDefinitionNode class >> isAbstract [

	^ self = ViennaTraceRepeatDefinitionNode
]
