Class {
	#name : #ViennaExtractValue,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractValue >> check [

	ast isViennaExpressionNode ifFalse: [ ^ false ].
	ast isViennaNameNode ifTrue: [ ^ false ].
	ast hasStatefulReference ifTrue: [ ^ false ].
	ast parent isViennaValueDefinitionNode ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractValue >> execute [

	| moduleBody valueDefinitions valueDefinition accessValueDefinition |
	self newName ifNil: [ ^ nil ].
	moduleBody := ast module third.
	valueDefinitions := (moduleBody
		                     detect: [ :definitionBlock |
			                     definitionBlock isViennaNode and: [
				                     definitionBlock first isViennaNode and: [
					                     definitionBlock first
						                     isViennaValueDefinitionsNode ] ] ]
		                     ifNone: [ nil ]) ifNotNil: #first.
	valueDefinitions ifNil: [
		valueDefinitions := ViennaValueDefinitionsNode empty.
		moduleBody add:
			(ViennaDefinitionBlockNode definition: valueDefinitions) ].
	self
		replaceNode: ast
		with: (ViennaLocalNameNode identifier: self newName).
	valueDefinition := ViennaValueDefinitionNode
		                   pattern:
		                   (ViennaPatternIdentifierNode identifier:
			                    self newName)
		                   type: nil
		                   expression: ast.
	accessValueDefinition := ViennaAccessValueDefinitionNode
		                         access: ViennaAccessNode empty
		                         valueDefinition: valueDefinition.
	valueDefinitions add: accessValueDefinition.
	^ accessValueDefinition
]

{ #category : #accessing }
ViennaExtractValue >> findNewName [
	(UIManager default
		request: 'name of toplevel value for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractValue >> name [

	^ 'Extract value '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractValue >> sortingOrder [
	^ 2.53
]
