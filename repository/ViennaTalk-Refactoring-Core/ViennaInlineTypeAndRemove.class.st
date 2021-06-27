Class {
	#name : #ViennaInlineTypeAndRemove,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineTypeAndRemove >> check [
	| moduleName shortName |
	ast ifNil: [ ^ false ].
	ast label = 'TypeDefinition'
		ifFalse: [ ^ false ].
	ast third ifNotNil: [ ^ false ].
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
											(node label = 'TypeImport' and: [ node first = shortName ])
												ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaInlineTypeAndRemove >> execute [
	| typeName typeBody |
	typeName := ast first.
	typeBody := ast second.
	self
		freeOccurrencesOf: typeName
		in: ast module
		do: [ :node | self replaceNode: node parent with: typeBody copyFragment ].
	(ast parentLabelled: 'TypeDefinitions' ifAbsent: [ nil ])
		ifNotNil: [ :typeDefinitions | 
			typeDefinitions remove: ast parent.
			typeDefinitions
				ifEmpty: [ typeDefinitions parent parent remove: typeDefinitions parent ] ].
	^ nil
]

{ #category : #accessing }
ViennaInlineTypeAndRemove >> name [
	^ 'Inline type definition of ' asText
		, (self shortDescription: ast source) asText allBold
		, ' and Remove' asText
]

{ #category : #accessing }
ViennaInlineTypeAndRemove >> sortingOrder [
	^ 2.12
]
