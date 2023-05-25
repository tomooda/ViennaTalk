Class {
	#name : #ViennaRenameExplicitFunction,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameExplicitFunction >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaRenameExplicitFunction >> construct [
	^ 'function'
]

{ #category : #operations }
ViennaRenameExplicitFunction >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :explicitFunctionDefinition | 
			explicitFunctionDefinition
				at: 1 put: self newName;
				at: 4 put: self newName ]
]

{ #category : #accessing }
ViennaRenameExplicitFunction >> findDefinitionNode [
	self oldName ifNil: [ ^ nil ].
	ast module third
		do: [ :definitionBlock | 
			definitionBlock first label = 'FunctionDefinitions'
				ifTrue: [ definitionBlock first
						do: [ :accessFunctionDef | 
							accessFunctionDef second first
								ifNotNil: [ :functionDef | 
									(functionDef label = 'ExplicitFunctionDefinition'
										and: [ functionDef first = self oldName
												and: [ functionDef fourth = self oldName ] ])
										ifTrue: [ ^ functionDef ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameExplicitFunction >> findOldName [

	ast label = 'ExplicitFunctionDefinition' ifTrue: [ ^ ast first ].
	ast isViennaLocalNameNode ifTrue: [ ^ ast first ].
	^ nil
]

{ #category : #accessing }
ViennaRenameExplicitFunction >> sortingOrder [
	^ 1.13
]
