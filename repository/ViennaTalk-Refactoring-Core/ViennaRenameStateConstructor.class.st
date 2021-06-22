Class {
	#name : #ViennaRenameStateConstructor,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameStateConstructor >> check [
	^ self definitionNode notNil
		and: [ self definitionNode first = self oldName ]
]

{ #category : #accessing }
ViennaRenameStateConstructor >> construct [
	^ 'state constructor'
]

{ #category : #operations }
ViennaRenameStateConstructor >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :stateDefinition | stateDefinition at: 1 put: self newName ]
]

{ #category : #accessing }
ViennaRenameStateConstructor >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'StateDefinition'
						ifTrue: [ ^ definitionBlock first ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameStateConstructor >> findOldName [
	ast label = 'StateDefinition'
		ifTrue: [ ^ ast first ].
	ast label = 'LocalName'
		ifTrue: [ ^ ast first ].
	^ nil
]

{ #category : #accessing }
ViennaRenameStateConstructor >> sortingOrder [
	^ 1.21
]
