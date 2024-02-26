Class {
	#name : #ViennaTraceDefinitionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTraceDefinitionNode class >> isAbstract [

	^ self = ViennaTraceDefinitionNode
]

{ #category : #private }
ViennaTraceDefinitionNode >> boundIdentifiersDo: aBlock [
]
