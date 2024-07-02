Class {
	#name : 'ViennaUse',
	#superclass : 'ViennaRefactoring',
	#instVars : [
		'definitionNode'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaUse class >> isAbstract [ 
	^ self == ViennaUse
]

{ #category : 'operations' }
ViennaUse >> check [

	^ self definitionNode notNil
]

{ #category : 'accessing' }
ViennaUse >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : 'accessing' }
ViennaUse >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : 'accessing' }
ViennaUse >> findDefinitionNode [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaUse >> sortingOrder [
	^ 2.11
]
