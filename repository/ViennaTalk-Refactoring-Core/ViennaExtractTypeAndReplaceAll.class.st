Class {
	#name : #ViennaExtractTypeAndReplaceAll,
	#superclass : #ViennaExtractType,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractTypeAndReplaceAll >> execute [

	| moduleBody typeDefinitions typeDefinition accessTypeDefinition |
	self newName ifNil: [ ^ self ].
	moduleBody := ast module third.
	typeDefinitions := (moduleBody
		                    detect: [ :definitionBlock |
			                    definitionBlock isViennaNode and: [
				                    definitionBlock first isViennaNode and: [
					                    definitionBlock first
						                    isViennaTypeDefinitionsNode ] ] ]
		                    ifNone: [ nil ]) ifNotNil: #first.
	typeDefinitions ifNil: [
		typeDefinitions := ViennaTypeDefinitionsNode empty.
		moduleBody add:
			(ViennaDefinitionBlockNode definition: typeDefinitions) ].
	ast module allDescendantsDo: [ :n |
		ast = n ifTrue: [
			self replaceNode: n with: (ViennaTypeNameNode name:
					 (ViennaLocalNameNode identifier: self newName)) ] ].
	typeDefinition := ViennaTypeSynonymNode
		                  identifier: self newName
		                  type: ast
		                  inv: nil.
	accessTypeDefinition := ViennaAccessTypeDefinitionNode
		                        access: ViennaAccessNode empty
		                        typeDefinition: typeDefinition.
	typeDefinitions add: accessTypeDefinition.
	^ accessTypeDefinition
]

{ #category : #accessing }
ViennaExtractTypeAndReplaceAll >> name [

	^ 'Extract type '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' and Replace all' asText
]

{ #category : #accessing }
ViennaExtractTypeAndReplaceAll >> sortingOrder [
	^ 2.52
]
