Class {
	#name : #ViennaRenameStateVariable,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameStateVariable >> check [
	^ self definitionNode notNil
		and: [ self definitionNode first = self oldName ]
]

{ #category : #accessing }
ViennaRenameStateVariable >> construct [
	^ 'state variable'
]

{ #category : #operations }
ViennaRenameStateVariable >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :stateDefinition | stateDefinition at: 1 put: self newName ]
]

{ #category : #operations }
ViennaRenameStateVariable >> executeOnImports [
]

{ #category : #accessing }
ViennaRenameStateVariable >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'StateDefinition'
						ifTrue: [ | stateDefinition |
							stateDefinition := definitionBlock first.
							stateDefinition second
								do: [ :field | 
									field first = self oldName
										ifTrue: [ ^ field ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameStateVariable >> findOldName [
	ast label = 'Field'
		ifTrue: [ ^ ast first ].
	ast label = 'LocalName'
		ifTrue: [ ^ ast first ].
	ast label = 'OldName'
		ifTrue: [ ^ ast first ].
	^ nil
]
