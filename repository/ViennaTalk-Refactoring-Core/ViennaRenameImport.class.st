Class {
	#name : #ViennaRenameImport,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameImport >> check [
	^ self definitionNode notNil
		and: [ (#('TypeImport' 'ValueImport' 'FunctionImport' 'OperationImport')
				includes: self definitionNode label)
				and: [ self definitionNode last isNil ] ]
]

{ #category : #accessing }
ViennaRenameImport >> construct [
	self definitionNode ifNil: [ ^ nil ].
	self definitionNode label = 'TypeImport'
		ifTrue: [ ^ 'type import' ].
	self definitionNode label = 'ValueImport'
		ifTrue: [ ^ 'value import' ].
	self definitionNode label = 'FunctionImport'
		ifTrue: [ ^ 'function import' ].
	self definitionNode label = 'OperationImport'
		ifTrue: [ ^ 'operation import' ].
	^ nil
]

{ #category : #operations }
ViennaRenameImport >> execute [
	self newName ifNil: [ ^ nil ].
	self executeOnDefinition.
	ast module
		allDescendantsDo: [ :node | 
			(node label = 'GlobalName'
				and: [ node first = self moduleName and: [ node second = self shortName ] ])
				ifTrue: [ self
						replaceNode: node
						with: (ViennaNode label: 'LocalName' with: self newName) ] ].
	^ ast
]

{ #category : #operations }
ViennaRenameImport >> executeOnDefinition [
	self newName ifNil: [ ^ nil ].
	^ self definitionNode
		at: self definitionNode size
			put: (ViennaNode label: 'LocalName' with: self newName);
		yourself
]

{ #category : #accessing }
ViennaRenameImport >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	(#('TypeImport' 'ValueImport' 'FunctionImport' 'OperationImport')
		includes: ast label)
		ifTrue: [ ^ ast ].
	ast label = 'GlobalName'
		ifTrue: [ ast module second first
				do: [ :importDefinition | 
					importDefinition first = ast first
						ifTrue: [ importDefinition second
								do: [ :importSignature | 
									importSignature
										do: [ :import | 
											import first first = ast second
												ifTrue: [ ^ import ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImport >> findNewName [
	(UIManager default request: 'new name' initialAnswer: self shortName)
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImport >> findOldName [
	ast ifNil: [ ^ nil ].
	^ self moduleName , '`' , self shortName
]

{ #category : #accessing }
ViennaRenameImport >> moduleName [
	^ self definitionNode parent parent parent first
]

{ #category : #accessing }
ViennaRenameImport >> shortName [
	^ self definitionNode label = 'TypeImport'
		ifTrue: [ self definitionNode first first first ]
		ifFalse: [ self definitionNode first first ]
]

{ #category : #accessing }
ViennaRenameImport >> sortingOrder [
	^ 1.1
]
