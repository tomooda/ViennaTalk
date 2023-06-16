Class {
	#name : #ViennaExtractType,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractType >> check [

	ast isTypeNode ifFalse: [ ^ false ].
	ast isViennaNameNode ifTrue: [ ast := ast parent ].
	^ true
]

{ #category : #operations }
ViennaExtractType >> execute [

	| moduleBody typeDefinitions typeDefinition accessTypeDefinition |
	self newName ifNil: [ ^ nil ].
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
	self replaceNode: ast with: (ViennaTypeNameNode name:
			 (ViennaLocalNameNode identifier: self newName)).
	typeDefinition := ViennaTypeSynonymNode
		                  identifier: self newName
		                  type: ast
		                  inv: nil.
	accessTypeDefinition := ViennaAccessTypeDefinitionNode
		                        access: (ViennaNode label: 'Access')
		                        typeDefinition: typeDefinition.
	typeDefinitions add: accessTypeDefinition.
	^ accessTypeDefinition
]

{ #category : #accessing }
ViennaExtractType >> findNewName [
	(UIManager default
		request: 'type name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractType >> name [

	^ 'Extract type '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractType >> sortingOrder [
	^ 2.51
]
