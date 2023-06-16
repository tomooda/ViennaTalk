Class {
	#name : #ViennaRenameExplicitOperation,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameExplicitOperation >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaRenameExplicitOperation >> construct [
	^ 'operation'
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

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first isViennaOperationDefinitionsNode ifTrue: [
				definitionBlock first do: [ :accessOperationDef |
					accessOperationDef second first ifNotNil: [ :operationDef |
						(operationDef isViennaExplicitOperationDefinitionNode:
							 self oldName) ifTrue: [ ^ operationDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameExplicitOperation >> findOldName [

	ast isViennaExplicitOperationDefinitionNode ifTrue: [
		^ ast identifier ].
	ast isViennaLocalNameNode ifTrue: [ ^ ast first ].
	^ nil
]

{ #category : #accessing }
ViennaRenameExplicitOperation >> sortingOrder [
	^ 1.11
]
