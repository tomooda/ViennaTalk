Class {
	#name : 'ViennaRenameStateVariable',
	#superclass : 'ViennaRenameToplevel',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaRenameStateVariable >> acceptsDefinitionNode: aViennaNode [

	^ aViennaNode isViennaFieldNode and: [
		  aViennaNode identifier = self oldName ]
]

{ #category : 'accessing' }
ViennaRenameStateVariable >> construct [
	^ 'state variable'
]

{ #category : 'operations' }
ViennaRenameStateVariable >> executeOnDefinition [

	self definitionNode ifNotNil: [ :field |
		field identifier: self newName ]
]

{ #category : 'operations' }
ViennaRenameStateVariable >> executeOnImports [
]

{ #category : 'accessing' }
ViennaRenameStateVariable >> sortingOrder [
	^ 1.22
]
