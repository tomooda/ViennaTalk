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
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'FunctionDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessFunctionDef | 
									accessFunctionDef second first
										ifNotNil: [ :functionDef | 
											(functionDef label = 'ImplicitFunctionDefinition'
												and: [ functionDef first = self oldName ])
												ifTrue: [ ^ functionDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImplicitFunction >> findOldName [
	ast label = 'ImplicitFunctionDefinition'
		ifTrue: [ ^ ast first ].
	ast label = 'LocalName'
		ifTrue: [ ^ ast first ].
	^ nil
]

{ #category : #accessing }
ViennaRenameImplicitFunction >> sortingOrder [
	^ 1.14
]
