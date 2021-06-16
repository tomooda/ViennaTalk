Class {
	#name : #ViennaRenameStateConstructor,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameStateConstructor >> check [
	^ self definitionNode notNil
		and: [ self definitionNode first = oldName ]
]

{ #category : #operations }
ViennaRenameStateConstructor >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :stateDefinition | stateDefinition at: 1 put: newName ]
]

{ #category : #accessing }
ViennaRenameStateConstructor >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ ^ definitionBlock first ] ].
	^ nil
]
