Class {
	#name : #ViennaRenameStateVariable,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameStateVariable >> check [
	^ self definitionNode notNil
		and: [ self definitionNode first = oldName ]
]

{ #category : #operations }
ViennaRenameStateVariable >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :stateDefinition | stateDefinition at: 1 put: newName ]
]

{ #category : #operations }
ViennaRenameStateVariable >> executeOnImports [
]

{ #category : #accessing }
ViennaRenameStateVariable >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ | stateDefinition |
					stateDefinition := definitionBlock first.
					stateDefinition second
						do: [ :field | 
							field first = oldName
								ifTrue: [ ^ field ] ] ] ].
	^ nil
]
