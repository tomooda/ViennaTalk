Class {
	#name : #ViennaRenameValue,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameValue >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRenameValue >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :valueDefinition | 
			self
				patternIdentifiersWith: oldName
				in: valueDefinition first
				do: [ :patternIdentifier | patternIdentifier at: 1 put: newName ] ]
]

{ #category : #accessing }
ViennaRenameValue >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'ValueDefinitions'
				ifTrue: [ definitionBlock first
						do: [ :accessValueDef | 
							accessValueDef second
								ifNotNil: [ :valueDef | 
									self
										patternIdentifiersWith: oldName
										in: valueDef first
										do: [ ^ valueDef ] ] ] ] ].
	^ nil
]
