Class {
	#name : 'ViennaRenameValue',
	#superclass : 'ViennaRenameToplevel',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaRenameValue >> acceptsDefinitionNode: aViennaNode [

	^ aViennaNode isViennaAccessValueDefinitionNode
]

{ #category : 'accessing' }
ViennaRenameValue >> construct [
	^ 'constant value'
]

{ #category : 'operations' }
ViennaRenameValue >> executeOnDefinition [

	self definitionNode ifNotNil: [ :valueDefinition |
		valueDefinition pattern boundIdentifiersDo: [ :identifier :pattern |
			identifier = self oldName ifTrue: [
				pattern identifier: self newName ] ] ]
]

{ #category : 'accessing' }
ViennaRenameValue >> sortingOrder [
	^ 1.4
]
