Class {
	#name : #ViennaRenameImplicitFunction,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameImplicitFunction >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRenameImplicitFunction >> executeOnDefinition [
	self definitionNode
		ifNotNil:
			[ :explicitFunctionDefinition | explicitFunctionDefinition at: 1 put: newName ]
]

{ #category : #accessing }
ViennaRenameImplicitFunction >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'FunctionDefinitions'
				ifTrue: [ definitionBlock first
						do: [ :accessFunctionDef | 
							accessFunctionDef second first
								ifNotNil: [ :functionDef | 
									(functionDef label = 'ImplicitFunctionDefinition'
										and: [ functionDef first = oldName ])
										ifTrue: [ ^ functionDef ] ] ] ] ].
	^ nil
]
