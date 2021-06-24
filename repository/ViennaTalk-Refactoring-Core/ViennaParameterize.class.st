Class {
	#name : #ViennaParameterize,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName',
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaParameterize class >> isAbstract [ 
	^ self == ViennaParameterize
]

{ #category : #accessing }
ViennaParameterize >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaParameterize >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaParameterize >> execute [
	self newName ifNil: [ ^ nil ].
	self executeReplacement.
	self executeCallers.
	^ self executeDefinition
]

{ #category : #operations }
ViennaParameterize >> executeCallers [
	^ self subclassResponsibility
]

{ #category : #operations }
ViennaParameterize >> executeDefinition [
	^ self subclassResponsibility
]

{ #category : #operations }
ViennaParameterize >> executeReplacement [
	self newName ifNil: [ ^ nil ].
	^ self
		replaceNode: ast
		with: (ViennaNode label: 'LocalName' with: self newName)
]

{ #category : #accessing }
ViennaParameterize >> findDefinitionNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaParameterize >> findNewName [
	(UIManager default
		request: 'new parameter name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaParameterize >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaParameterize >> newName: aString [
	newName := aString
]
