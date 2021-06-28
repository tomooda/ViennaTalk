Class {
	#name : #ViennaUse,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaUse class >> isAbstract [ 
	^ self == ViennaUse
]

{ #category : #operations }
ViennaUse >> check [
	^ self definitionNode notNil and: [ self identifier notNil ]
]

{ #category : #accessing }
ViennaUse >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaUse >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #accessing }
ViennaUse >> findDefinitionNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaUse >> identifier [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaUse >> name [
	^ 'Use ' , self identifier asText allBold , ' for '
		, (self shortDescription: self ast source) asText allBold
]

{ #category : #accessing }
ViennaUse >> sortingOrder [
	^ 2.11
]
