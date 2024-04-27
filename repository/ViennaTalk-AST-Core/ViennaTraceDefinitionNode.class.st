Class {
	#name : #ViennaTraceDefinitionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaTraceDefinitionNode class >> isAbstract [

	^ self = ViennaTraceDefinitionNode
]

{ #category : #private }
ViennaTraceDefinitionNode >> boundIdentifiersDo: aBlock [
]
