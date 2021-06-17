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

{ #category : #testing }
ViennaRename class >> isAbstract [
	^ self = ViennaRename
]

{ #category : #accessing }
ViennaRename >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #operations }
ViennaRename >> execute [
	self
		executeOnDefinition;
		freeOccurrencesOf: self oldName
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
	aViennaNode at: 1 put: self newName
]

{ #category : #operations }
ViennaRename >> executeOldName: aViennaNode [
	aViennaNode at: 1 put: self newName
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
ViennaRename >> findNewName [
	(UIManager default
		request: 'rename function'
		initialAnswer: self oldName)
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaRename >> findOldName [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaRename >> name [
	^ 'rename ' asText , self oldName asText allBold
		,
			(newName
				ifNotNil: [ ' to ' asText , newName asText allBold ]
				ifNil: [ '' asText ])
]

{ #category : #accessing }
ViennaRename >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaRename >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaRename >> oldName [
	^ oldName ifNil: [ oldName := self findOldName ]
]

{ #category : #accessing }
ViennaRename >> oldName: aString [
	oldName := aString
]
