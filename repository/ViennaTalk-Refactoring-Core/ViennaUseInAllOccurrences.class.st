Class {
	#name : #ViennaUseInAllOccurrences,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaUseInAllOccurrences class >> isAbstract [
	^ self == ViennaUseInAllOccurrences
]

{ #category : #operations }
ViennaUseInAllOccurrences >> check [
	^ self definitionNode notNil and: [ self identifier notNil ]
]

{ #category : #accessing }
ViennaUseInAllOccurrences >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaUseInAllOccurrences >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #accessing }
ViennaUseInAllOccurrences >> findDefinitionNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaUseInAllOccurrences >> identifier [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaUseInAllOccurrences >> name [
	^ 'Use ' , self identifier asText allBold
		, ' for all occurrences of '
		, (self shortDescription: self ast source) asText allBold
]

{ #category : #accessing }
ViennaUseInAllOccurrences >> sortingOrder [
	^ 2.12
]
