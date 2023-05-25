Class {
	#name : #ViennaMultipleBindNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaMultipleBindNode >> patternList [

	^ self at: 1
]

{ #category : #enumerating }
ViennaMultipleBindNode >> patternsDo: aBlock [

	self patternList do: aBlock
]
