Class {
	#name : #ViennaRenameImplicitOperation,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameImplicitOperation >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRenameImplicitOperation >> executeOnDefinition [
	self definitionNode
		ifNotNil:
			[ :implicitOperationDefinition | implicitOperationDefinition at: 1 put: newName ]
]

{ #category : #accessing }
ViennaRenameImplicitOperation >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'OperationDefinitions'
				ifTrue: [ definitionBlock first
						do: [ :accessOperationDef | 
							accessOperationDef second first
								ifNotNil: [ :operationDef | 
									(operationDef label = 'ImplicitOperationDefinition'
										and: [ operationDef first = oldName ])
										ifTrue: [ ^ operationDef ] ] ] ] ].
	^ nil
]
