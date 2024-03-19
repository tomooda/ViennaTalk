Class {
	#name : #ViennaRenameStateConstructor,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaRenameStateConstructor >> acceptsDefinitionNode: aViennaNode [

	^ aViennaNode isViennaStateDefinitionNode and: [
		  aViennaNode identifier = self oldName ]
]

{ #category : #accessing }
ViennaRenameStateConstructor >> construct [
	^ 'state constructor'
]

{ #category : #testing }
ViennaRenameStateConstructor >> isForCategoryList [

	^ true
]

{ #category : #accessing }
ViennaRenameStateConstructor >> sortingOrder [
	^ 1.21
]
