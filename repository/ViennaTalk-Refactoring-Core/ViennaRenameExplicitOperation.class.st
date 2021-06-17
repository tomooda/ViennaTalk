Class {
	#name : #ViennaRenameExplicitOperation,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameExplicitOperation >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRenameExplicitOperation >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :explicitOperationDefinition | 
			explicitOperationDefinition
				at: 1 put: self newName;
				at: 3 put: self newName ]
]

{ #category : #accessing }
ViennaRenameExplicitOperation >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'OperationDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessOperationDef | 
									accessOperationDef second first
										ifNotNil: [ :operationDef | 
											(operationDef label = 'ExplicitOperationDefinition'
												and: [ operationDef first = self oldName
														and: [ operationDef third = self oldName ] ])
												ifTrue: [ ^ operationDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameExplicitOperation >> findOldName [
	ast label = 'ExplicitOperationDefinition'
		ifTrue: [ ^ ast first ].
	ast label = 'LocalName'
		ifTrue: [ ^ ast first ].
	^ nil
]
