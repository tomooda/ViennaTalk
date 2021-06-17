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
				patternIdentifiersWith: self oldName
				in: valueDefinition first
				do: [ :patternIdentifier | patternIdentifier at: 1 put: self newName ] ]
]

{ #category : #accessing }
ViennaRenameValue >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'ValueDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessValueDef | 
									accessValueDef second
										ifNotNil: [ :valueDef | 
											self
												patternIdentifiersWith: self oldName
												in: valueDef first
												do: [ ^ valueDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameValue >> findOldName [
	(ast label = 'ValueDefinition'
		and: [ ast first label = 'PatternIdentifier' ])
		ifTrue: [ ^ ast first first ].
	ast label = 'PatternIdentifier'
		ifTrue: [ ^ ast first ].
	ast label = 'LocalName'
		ifTrue: [ ^ ast first ].
	^ nil
]
