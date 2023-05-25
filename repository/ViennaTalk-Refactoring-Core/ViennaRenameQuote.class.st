Class {
	#name : #ViennaRenameQuote,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameQuote >> check [

	ast document allDescendantsDo: [ :node |
		(node label = 'QuoteType' and: [ node first = self oldName ])
			ifTrue: [ ^ true ].
		(node isViennaSymbolicLiteralNode and: [ node string = self oldName ])
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
ViennaRenameQuote >> construct [
	^ 'quote'
]

{ #category : #operations }
ViennaRenameQuote >> execute [

	self newName ifNil: [ ^ nil ].
	ast document allDescendantsDo: [ :node |
		(node label = 'QuoteType' and: [ node first = self oldName ])
			ifTrue: [ node at: 1 put: self newName ].
		(node isViennaSymbolicLiteralNode and: [ node string = self oldName ])
			ifTrue: [ node string: self newName ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameQuote >> findDefinitionNode [
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

	ast label = 'QuoteType' ifTrue: [ ^ ast first ].
	(ast isViennaSymbolicLiteralNode and: [
		 ast string notEmpty and: [
			 ast string first = $< and: [ ast string last = $> ] ] ]) ifTrue: [
		^ ast string ].
	^ nil
]

{ #category : #accessing }
ViennaRenameQuote >> sortingOrder [
	^ 1.5
]
