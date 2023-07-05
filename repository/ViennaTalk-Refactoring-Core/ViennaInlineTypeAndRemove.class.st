Class {
	#name : #ViennaInlineTypeAndRemove,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineTypeAndRemove >> check [

	| moduleName shortName |
	ast ifNil: [ ^ false ].
	ast isViennaAccessTypeDefinitionNode ifTrue: [
		ast := ast typeDefinition ].
	(ast isViennaTypeSynonymNode or: [
		 ast isViennaRecordTypeDefinitionNode ]) ifFalse: [ ^ false ].
	(((ast isViennaTypeSynonymNode and: [ ast inv notNil ]) or: [
		  ast isViennaRecordTypeDefinitionNode ]) and: [
		 self hasFreeOccurrencesOf: ast identifier in: ast module ])
		ifTrue: [ ^ false ].
	moduleName := ast module identifier.
	shortName := ast identifier.
	ast document allDescendantsDo: [ :node |
		(node isViennaGlobalNameNode: moduleName identifier: shortName)
			ifTrue: [ ^ false ] ].
	ast modulesDo: [ :module |
		module second first ifNotNil: [ :importDefinitionList |
			importDefinitionList do: [ :importDefinition |
				importDefinition first = moduleName ifTrue: [
					importDefinition allDescendantsDo: [ :node |
						(node isViennaTypeImportNode: shortName) ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaInlineTypeAndRemove >> execute [

	| typeName typeBody |
	typeName := ast identifier.
	typeBody := ast type.
	ast document
		allDescendantsSuchThat: [ :node |
		node isViennaTypeNameNode: typeName ]
		do: [ :node | self replaceNode: node with: typeBody copyFragment ].
	^ (ast parent ifNotNil: #parent) ifNotNil: [ :typesSection |
		  typesSection isViennaTypeDefinitionsNode ifFalse: [ ^ nil ].
		  typesSection remove: ast parent.
		  typesSection removeIfEmpty ]
]

{ #category : #accessing }
ViennaInlineTypeAndRemove >> name [

	ast isViennaRecordTypeDefinitionNode ifTrue: [
		^ 'Remove record type ' asText , ast first asText allBold ].
	^ 'Inline type definition of ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' and Remove' asText
]

{ #category : #accessing }
ViennaInlineTypeAndRemove >> sortingOrder [
	^ 2.12
]
