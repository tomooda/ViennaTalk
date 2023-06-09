Class {
	#name : #ViennaInlineTypeAndRemove,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineTypeAndRemove >> check [

	| moduleName shortName |
	ast ifNil: [ ^ false ].
	(#( 'TypeDefinition' 'RecordTypeDefinition' ) includes: ast label)
		ifFalse: [ ^ false ].
	(((ast label = 'TypeDefinition' and: [ ast third notNil ]) or: [
		  ast label = 'RecordTypeDefinition' ]) and: [
		 self hasFreeOccurrencesOf: ast first in: ast module ]) ifTrue: [
		^ false ].
	(ast label = 'TypeDefinition' and: [
		 ast third notNil and: [
			 self hasFreeOccurrencesOf: ast first in: ast module ] ]) ifTrue: [
		^ false ].
	moduleName := ast module first.
	shortName := ast first.
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
	ast label = 'RecordTypeDefinition'
		ifTrue: [ ^ 'Remove record type ' asText , ast first asText allBold ].
	^ 'Inline type definition of ' asText
		, (self shortDescription: ast source) asText allBold
		, ' and Remove' asText
]

{ #category : #accessing }
ViennaInlineTypeAndRemove >> sortingOrder [
	^ 2.12
]
