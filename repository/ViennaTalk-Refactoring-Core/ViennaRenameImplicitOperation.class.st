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

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first isViennaOperationDefinitionsNode ifTrue: [
				definitionBlock first do: [ :accessOperationDef |
					accessOperationDef operationDefinition definition ifNotNil: [
						:operationDef |
						(operationDef isViennaImplicitOperationDefinitionNode:
							 self oldName) ifTrue: [ ^ operationDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImplicitOperation >> findOldName [

	ast isViennaImplicitOperationDefinitionNode ifTrue: [
		^ ast identifier ].
	ast isViennaLocalNameNode ifTrue: [ ^ ast identifier ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImplicitOperation >> sortingOrder [
	^ 1.12
]
