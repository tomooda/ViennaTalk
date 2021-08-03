Class {
	#name : #ViennaExtractParameter,
	#superclass : #ViennaExtract,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaExtractParameter class >> isAbstract [ 
	^ self == ViennaExtractParameter
]

{ #category : #accessing }
ViennaExtractParameter >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaExtractParameter >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaExtractParameter >> execute [
	self newName ifNil: [ ^ nil ].
	self executeReplacement.
	self executeCallers.
	^ self executeDefinition
]

{ #category : #operations }
ViennaExtractParameter >> executeCallers [
	^ self subclassResponsibility
]

{ #category : #operations }
ViennaExtractParameter >> executeDefinition [
	^ self subclassResponsibility
]

{ #category : #operations }
ViennaExtractParameter >> executeReplacement [
	self newName ifNil: [ ^ nil ].
	^ self
		replaceNode: ast
		with: (ViennaNode label: 'LocalName' with: self newName)
]

{ #category : #accessing }
ViennaExtractParameter >> findDefinitionNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaExtractParameter >> findNewName [
	(UIManager default
		request: 'new parameter name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractParameter >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaExtractParameter >> newName: aString [
	newName := aString
]
