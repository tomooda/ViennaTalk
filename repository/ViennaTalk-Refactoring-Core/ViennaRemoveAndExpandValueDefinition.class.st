Class {
	#name : #ViennaRemoveAndExpandValueDefinition,
	#superclass : #ViennaRefactoring,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRemoveAndExpandValueDefinition >> check [
	| moduleName shortName |
	ast ifNil: [ ^ false ].
	ast label = 'ValueDefinition'
		ifFalse: [ ^ false ].
	ast first label = 'PatternIdentifier'
		ifFalse: [ ^ false ].
	moduleName := ast module first.
	shortName := ast first.
	ast document
		allDescendantsDo: [ :node | 
			(node label = 'GlobalName'
				and: [ node first = moduleName and: [ node second = shortName ] ])
				ifTrue: [ ^ false ] ].
	ast
		modulesDo: [ :module | 
			module second first
				ifNotNil: [ :importDefinitionList | 
					importDefinitionList
						do: [ :importDefinition | 
							importDefinition first = moduleName
								ifTrue: [ importDefinition
										allDescendantsDo: [ :node | 
											(node label = 'ValueImport' and: [ node first = shortName ])
												ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaRemoveAndExpandValueDefinition >> execute [
	| valueName valueBody |
	valueName := ast first first.
	valueBody := ast third.
	self
		freeOccurrencesOf: valueName
		in: ast module
		do: [ :node | self replaceNode: node with: valueBody copyFragment ].
	(ast parentLabelled: 'ValueDefinitions' ifAbsent: [ nil ])
		ifNotNil: [ :valueDefinitions | 
			valueDefinitions remove: ast parent.
			valueDefinitions
				ifEmpty: [ valueDefinitions parent parent remove: valueDefinitions parent ] ].
	^ nil
]

{ #category : #accessing }
ViennaRemoveAndExpandValueDefinition >> name [
	^ 'remove value definition of ' asText
		, ast first source asText allBold , ' and expand it' asText
]
