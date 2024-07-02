Class {
	#name : 'ViennaRenameQuote',
	#superclass : 'ViennaRename',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaRenameQuote >> check [

	^ self oldName notNil
]

{ #category : 'accessing' }
ViennaRenameQuote >> construct [
	^ 'quote'
]

{ #category : 'operations' }
ViennaRenameQuote >> execute [

	self newName ifNil: [ ^ nil ].
	ast document allDescendantsDo: [ :node |
		(node isViennaQuoteTypeNode: self oldName) ifTrue: [
			node string: self newName ].
		(node isViennaSymbolicLiteralNode: self oldName) ifTrue: [
			node string: self newName ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaRenameQuote >> findDefinitionNode [
	^ nil
]

{ #category : 'accessing' }
ViennaRenameQuote >> findNewName [
	(UIManager default
		request: 'rename quote'
		initialAnswer: self oldName allButFirst allButLast)
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ '<' , name , '>' ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaRenameQuote >> findOldName [

	ast isViennaQuoteTypeNode ifTrue: [ ^ ast string ].
	(ast isViennaSymbolicLiteralNode and: [
		 ast string notEmpty and: [
			 ast string first = $< and: [ ast string last = $> ] ] ]) ifTrue: [
		^ ast string ].
	^ nil
]

{ #category : 'accessing' }
ViennaRenameQuote >> sortingOrder [
	^ 1.5
]
