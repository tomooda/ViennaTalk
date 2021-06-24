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
	self newName ifNil: [ ^ nil ].
	ast document
		allDescendantsDo: [ :node | 
			(node label = 'QuoteType' and: [ node first = self oldName ])
				ifTrue: [ node at: 1 put: self newName ].
			(node label = 'SymbolicLiteral' and: [ node first = self oldName ])
				ifTrue: [ node at: 1 put: self newName ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameQuote >> findNewName [
	(UIManager default
		request: 'rename quote'
		initialAnswer: self oldName allButFirst allButLast)
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ '<' , name , '>' ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameQuote >> findOldName [
	ast label = 'QuoteType'
		ifTrue: [ ^ ast first ].
	(ast label = 'SymbolicLiteral'
		and: [ ast first notEmpty
				and: [ ast first first = $< and: [ ast first last = $> ] ] ])
		ifTrue: [ ^ ast first ].
	^ nil
]

{ #category : #accessing }
ViennaRenameQuote >> name [
	^ 'Rename ' asText , oldName asText allBold
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

{ #category : #accessing }
ViennaRenameQuote >> sortingOrder [
	^ 1.5
]
