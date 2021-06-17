Class {
	#name : #ViennaRenameType,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameType >> check [
	^ self definitionNode notNil
		and: [ self definitionNode first = self oldName ]
]

{ #category : #operations }
ViennaRenameType >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :typeDefinition | typeDefinition at: 1 put: self newName ]
]

{ #category : #accessing }
ViennaRenameType >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'TypeDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessTypeDef | 
									accessTypeDef second
										ifNotNil: [ :typeDef | 
											typeDef first = self oldName
												ifTrue: [ ^ typeDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameType >> findOldName [
	ast label = 'TypeDefinition'
		ifTrue: [ ^ ast first ].
	ast label = 'RecordTypeDefinition'
		ifTrue: [ ^ ast first ].
	ast label = 'LocalName'
		ifTrue: [ ^ ast first ].
	^ nil
]
