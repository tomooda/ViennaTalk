Class {
	#name : #ViennaRenameQuote,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameQuote >> check [
	ast document
		allDescendantsDo: [ :node | 
			(node label = 'QuoteType' and: [ node first = self oldName ])
				ifTrue: [ ^ true ].
			(node label = 'SymbolicLiteral' and: [ node first = self oldName ])
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #operations }
ViennaRenameQuote >> execute [
	ast document
		allDescendantsDo: [ :node | 
			(node label = 'QuoteType' and: [ node first = self oldName ])
				ifTrue: [ node at: 1 put: self newName ].
			(node label = 'SymbolicLiteral' and: [ node first = self oldName ])
				ifTrue: [ node at: 1 put: self newName ] ]
]

{ #category : #accessing }
ViennaRenameQuote >> findNewName [
	(UIManager default
		request: 'rename function'
		initialAnswer: self oldName allButFirst allButLast)
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ '<' , name , '>' ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameQuote >> findOldName [
	ast label = 'QuoteType'
		ifTrue: [ ^ ast first ].
	ast label = 'SymbolicLiteral'
		ifTrue: [ ^ ast second ].
	^ nil
]

{ #category : #accessing }
ViennaRenameQuote >> name [
	^ 'rename ' asText , oldName asText allBold
		,
			(newName
				ifNotNil: [ ' into ' asText , newName asText allBold ]
				ifNil: [ '' asText ])
]

{ #category : #accessing }
ViennaRenameQuote >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaRenameQuote >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaRenameQuote >> oldName [
	^ oldName ifNil: [ oldName := self findOldName ]
]

{ #category : #accessing }
ViennaRenameQuote >> oldName: aString [
	oldName := aString
]
