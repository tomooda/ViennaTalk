Class {
	#name : #ViennaInlineValueAndRemove,
	#superclass : #ViennaRefactoring,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineValueAndRemove >> check [
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
ViennaInlineValueAndRemove >> execute [
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
ViennaInlineValueAndRemove >> name [
	^ 'Inline value definition of ' asText
		, (self shortDescription: ast first source) asText allBold
		, ' and Remove' asText
]

{ #category : #accessing }
ViennaInlineValueAndRemove >> sortingOrder [
	^ 2.15
]
