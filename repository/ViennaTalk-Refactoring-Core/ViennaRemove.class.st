Class {
	#name : 'ViennaRemove',
	#superclass : 'ViennaRefactoring',
	#instVars : [
		'definitionNode'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaRemove class >> isAbstract [
	^ self == ViennaRemove
]

{ #category : 'accessing' }
ViennaRemove >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : 'accessing' }
ViennaRemove >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : 'accessing' }
ViennaRemove >> findDefinitionNode [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaRemove >> name [

	^ 'Remove ' , self definitionNode identifier asText allBold
]
