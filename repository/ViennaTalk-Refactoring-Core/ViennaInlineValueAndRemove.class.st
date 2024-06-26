Class {
	#name : 'ViennaInlineValueAndRemove',
	#superclass : 'ViennaInline',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaInlineValueAndRemove >> check [

	| moduleIdentifier identifier |
	ast ifNil: [ ^ false ].
	ast isViennaValueDefinitionNode ifFalse: [ ^ false ].
	ast pattern isViennaPatternIdentifierNode ifFalse: [ ^ false ].
	moduleIdentifier := ast module identifier.
	identifier := ast pattern identifier.
	(ast document
		 hasGlobalReferenceToModule: moduleIdentifier
		 identifier: identifier) ifTrue: [ ^ false ].
	ast modulesDo: [ :module |
		(module importsFrom: moduleIdentifier identifier: identifier)
			ifTrue: [ ^ false ] ].
	^ true
]

{ #category : 'operations' }
ViennaInlineValueAndRemove >> execute [

	| valueName valueBody |
	valueName := ast pattern identifier.
	valueBody := ast expression.
	ast module
		allDescendantsSuchThat: [ :node |
			(node isViennaLocalNameNode: valueName) and: [ node resolve == ast ] ]
		do: [ :node | self replaceNode: node with: valueBody copyFragment ].
	ast parent ifNotNil: [ :valuesSection |
		valuesSection isViennaValueDefinitionsNode ifTrue: [
			valuesSection remove: ast.
			valuesSection removeIfEmpty ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaInlineValueAndRemove >> name [

	^ 'Inline value definition of ' asText
	  , (self shortDescription: ast pattern source) asText allBold
	  , ' and Remove' asText
]

{ #category : 'accessing' }
ViennaInlineValueAndRemove >> sortingOrder [
	^ 2.15
]
