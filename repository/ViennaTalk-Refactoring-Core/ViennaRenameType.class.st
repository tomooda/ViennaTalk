Class {
	#name : #ViennaRenameType,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameType >> check [
	^ self definitionNode notNil
		and: [ self definitionNode first = oldName ]
]

{ #category : #operations }
ViennaRenameType >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :typeDefinition | typeDefinition at: 1 put: newName ]
]

{ #category : #accessing }
ViennaRenameType >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'TypeDefinitions'
				ifTrue: [ definitionBlock first
						do: [ :accessTypeDef | 
							accessTypeDef second
								ifNotNil: [ :typeDef | 
									typeDef first = oldName
										ifTrue: [ ^ typeDef ] ] ] ] ].
	^ nil
]
