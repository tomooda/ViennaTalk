Class {
	#name : #ViennaRenameImport,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameImport >> check [

	^ self definitionNode notNil and: [
		  self definitionNode isViennaImportNode and: [
			  self definitionNode rename isNil ] ]
]

{ #category : #accessing }
ViennaRenameImport >> construct [

	self definitionNode ifNil: [ ^ nil ].
	self definitionNode isViennaTypeImportNode ifTrue: [ ^ 'type import' ].
	self definitionNode isViennaValueImportNode ifTrue: [
		^ 'value import' ].
	self definitionNode isViennaFunctionImportNode ifTrue: [
		^ 'function import' ].
	self definitionNode isViennaOperationImportNode ifTrue: [
		^ 'operation import' ].
	^ nil
]

{ #category : #operations }
ViennaRenameImport >> execute [

	self newName ifNil: [ ^ nil ].
	self executeOnDefinition.
	ast module allDescendantsDo: [ :node |
		(node
			 isViennaGlobalNameNode: self moduleName
			 identifier: self shortName) ifTrue: [
			self
				replaceNode: node
				with: (ViennaLocalNameNode identifier: self newName) ] ].
	^ ast
]

{ #category : #operations }
ViennaRenameImport >> executeOnDefinition [

	self newName ifNil: [ ^ nil ].
	^ self definitionNode
		  at: self definitionNode size
		  put: (ViennaLocalNameNode identifier: self newName);
		  yourself
]

{ #category : #accessing }
ViennaRenameImport >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast isViennaImportNode ifTrue: [ ^ ast ].
	ast isViennaGlobalNameNode ifTrue: [
		ast module second first do: [ :importDefinition |
			importDefinition first = ast first ifTrue: [
				importDefinition second do: [ :importSignature |
					importSignature do: [ :import |
						import first first = ast second ifTrue: [ ^ import ] ] ] ] ] ].
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

	^ self definitionNode identifier
]

{ #category : #accessing }
ViennaRenameImport >> sortingOrder [
	^ 1.1
]
