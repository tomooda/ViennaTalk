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

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock definition isViennaStateDefinitionNode ifTrue: [
				| stateDefinition |
				stateDefinition := definitionBlock definition.
				stateDefinition fieldList do: [ :field |
					field identifier = self oldName ifTrue: [ ^ field ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameStateVariable >> findOldName [

	ast isViennaFieldNode ifTrue: [ ^ ast identifier ].
	ast isViennaLocalNameNode ifTrue: [ ^ ast identifier ].
	ast isViennaOldNameNode ifTrue: [ ^ ast identifier ].
	^ nil
]

{ #category : #accessing }
ViennaRenameStateVariable >> sortingOrder [
	^ 1.22
]
