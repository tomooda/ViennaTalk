Class {
	#name : #ViennaRenameExplicitFunction,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameExplicitFunction >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRenameExplicitFunction >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :explicitFunctionDefinition | 
			explicitFunctionDefinition
				at: 1 put: newName;
				at: 4 put: newName ]
]

{ #category : #accessing }
ViennaRenameExplicitFunction >> findDefinitionNode [
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'FunctionDefinitions'
				ifTrue: [ definitionBlock first
						do: [ :accessFunctionDef | 
							accessFunctionDef second first
								ifNotNil: [ :functionDef | 
									(functionDef label = 'ExplicitFunctionDefinition'
										and: [ functionDef first = oldName and: [ functionDef fourth = oldName ] ])
										ifTrue: [ ^ functionDef ] ] ] ] ].
	^ nil
]
