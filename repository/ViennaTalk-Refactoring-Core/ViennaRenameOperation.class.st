Class {
	#name : 'ViennaRenameOperation',
	#superclass : 'ViennaRenameToplevel',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaRenameOperation >> acceptsDefinitionNode: aViennaNode [

	^ aViennaNode isViennaAccessOperationDefinitionNode and: [
		  aViennaNode identifier = self oldName ]
]

{ #category : 'accessing' }
ViennaRenameOperation >> construct [
	^ 'operation'
]

{ #category : 'accessing' }
ViennaRenameOperation >> sortingOrder [
	^ 1.11
]
