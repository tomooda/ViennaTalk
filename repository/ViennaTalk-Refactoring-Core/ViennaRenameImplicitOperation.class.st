Class {
	#name : #ViennaRenameImplicitOperation,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameImplicitOperation >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaRenameImplicitOperation >> construct [
	^ 'operation'
]

{ #category : #operations }
ViennaRenameImplicitOperation >> executeOnDefinition [
	self definitionNode
		ifNotNil:
			[ :implicitOperationDefinition | implicitOperationDefinition at: 1 put: self newName ]
]

{ #category : #accessing }
ViennaRenameImplicitOperation >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'OperationDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessOperationDef | 
									accessOperationDef second first
										ifNotNil: [ :operationDef | 
											(operationDef label = 'ImplicitOperationDefinition'
												and: [ operationDef first = self oldName ])
												ifTrue: [ ^ operationDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImplicitOperation >> findOldName [
	ast label = 'ImplicitOperationDefinition'
		ifTrue: [ ^ ast first ].
	ast label = 'LocalName'
		ifTrue: [ ^ ast first ].
	^ nil
]
