Class {
	#name : #ViennaRename,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'oldName',
		'newName',
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaRename >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #operations }
ViennaRename >> execute [
	self
		executeOnDefinition;
		freeOccurrencesOf: oldName
			in: ast module
			do: [ :node | self execute: node ]
]

{ #category : #operations }
ViennaRename >> execute: aViennaNode [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('execute' , aViennaNode label , ':') asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self perform: selector with: aViennaNode ]
		ifFalse: [ self refactoringError: aViennaNode ]
]

{ #category : #operations }
ViennaRename >> executeLocalName: aViennaNode [
	aViennaNode at: 1 put: newName
]

{ #category : #operations }
ViennaRename >> executeOnDefinition [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaRename >> findDefinitionNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaRename >> newName [
	^ newName
]

{ #category : #accessing }
ViennaRename >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaRename >> oldName [
	^ oldName
]

{ #category : #accessing }
ViennaRename >> oldName: aString [
	oldName := aString
]
