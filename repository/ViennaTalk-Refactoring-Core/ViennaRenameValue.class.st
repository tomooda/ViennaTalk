Class {
	#name : #ViennaRenameValue,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameValue >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaRenameValue >> construct [
	^ 'constant value'
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

	(ast label = 'ValueDefinition' and: [
		 ast first isViennaPatternIdentifierNode ]) ifTrue: [
		^ ast first first ].
	ast isViennaPatternIdentifierNode ifTrue: [ ^ ast first ].
	ast isViennaLocalNameNode ifTrue: [ ^ ast first ].
	^ nil
]

{ #category : #accessing }
ViennaRenameValue >> sortingOrder [
	^ 1.4
]
