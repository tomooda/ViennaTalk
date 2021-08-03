Class {
	#name : #ViennaExtractType,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractType >> check [
	ast isTypeNode
		ifFalse: [ ^ false ].
	(ast label = 'LocalName' or: [ ast label = 'GlobalName' ])
		ifTrue: [ ast := ast parent ].
	^ true
]

{ #category : #operations }
ViennaExtractType >> execute [
	| moduleBody typeDefinitions typeDefinition accessTypeDefinition |
	self newName ifNil: [ ^ nil ].
	moduleBody := ast module third.
	typeDefinitions := (moduleBody
		detect: [ :definitionBlock | 
			definitionBlock isViennaNode
				and: [ definitionBlock first isViennaNode
						and: [ definitionBlock first label = 'TypeDefinitions' ] ] ]
		ifNone: [ nil ]) ifNotNil: #first.
	typeDefinitions
		ifNil: [ typeDefinitions := ViennaNode label: 'TypeDefinitions'.
			moduleBody
				add: (ViennaNode label: 'DefinitionBlock' with: typeDefinitions) ].
	self
		replaceNode: ast
		with:
			(ViennaNode
				label: 'TypeName'
				with: (ViennaNode label: 'LocalName' with: self newName)).
	typeDefinition := ViennaNode
		label: 'TypeDefinition'
		with: self newName
		with: ast
		with: nil.
	accessTypeDefinition := ViennaNode
		label: 'AccessTypeDefinition'
		with: (ViennaNode label: 'Access')
		with: typeDefinition.
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
	^ 'Extract type from ' asText
		, (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractType >> sortingOrder [
	^ 2.51
]
