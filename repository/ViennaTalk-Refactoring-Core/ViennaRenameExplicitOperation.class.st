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
				at: 1 put: newName;
				at: 3 put: newName ]
]

{ #category : #accessing }
ViennaRenameExplicitOperation >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'OperationDefinitions'
				ifTrue: [ definitionBlock first
						do: [ :accessOperationDef | 
							accessOperationDef second first
								ifNotNil: [ :operationDef | 
									(operationDef label = 'ExplicitOperationDefinition'
										and: [ operationDef first = oldName and: [ operationDef third = oldName ] ])
										ifTrue: [ ^ operationDef ] ] ] ] ].
	^ nil
]
