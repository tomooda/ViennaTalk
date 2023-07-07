Class {
	#name : #ViennaRenameType,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaRenameType >> acceptsDefinitionNode: aViennaNode [

	^ aViennaNode isViennaAccessTypeDefinitionNode and: [
		  aViennaNode identifier = self oldName ]
]

{ #category : #accessing }
ViennaRenameType >> construct [
	^ 'type'
]

{ #category : #accessing }
ViennaRenameType >> sortingOrder [
	^ 1.3
]
