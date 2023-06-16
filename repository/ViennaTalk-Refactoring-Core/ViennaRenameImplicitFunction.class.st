Class {
	#name : #ViennaRenameImplicitFunction,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameImplicitFunction >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaRenameImplicitFunction >> construct [
	^ 'function'
]

{ #category : #operations }
ViennaRenameImplicitFunction >> executeOnDefinition [
	self definitionNode
		ifNotNil:
			[ :explicitFunctionDefinition | explicitFunctionDefinition at: 1 put: self newName ]
]

{ #category : #accessing }
ViennaRenameImplicitFunction >> findDefinitionNode [

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first isViennaFunctionDefinitionsNode ifTrue: [
				definitionBlock first do: [ :accessFunctionDef |
					accessFunctionDef second first ifNotNil: [ :functionDef |
						(functionDef isViennaImplicitFunctionDefinitionNode:
							 self oldName) ifTrue: [ ^ functionDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImplicitFunction >> findOldName [

	ast isViennaImplicitFunctionDefinitionNode ifTrue: [
		^ ast identifier ].
	ast isViennaLocalNameNode ifTrue: [ ^ ast identifier ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImplicitFunction >> sortingOrder [
	^ 1.14
]
