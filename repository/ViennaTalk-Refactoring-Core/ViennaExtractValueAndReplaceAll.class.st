Class {
	#name : #ViennaExtractValueAndReplaceAll,
	#superclass : #ViennaExtractValue,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractValueAndReplaceAll >> execute [

	| moduleBody valueDefinitions valueDefinition accessValueDefinition |
	self newName ifNil: [ ^ self ].
	moduleBody := ast module third.
	valueDefinitions := (moduleBody
		                     detect: [ :definitionBlock |
			                     definitionBlock isViennaNode and: [
				                     definitionBlock first isViennaNode and: [
					                     definitionBlock first label
					                     = 'ValueDefinitions' ] ] ]
		                     ifNone: [ nil ]) ifNotNil: #first.
	valueDefinitions ifNil: [
		valueDefinitions := ViennaNode label: 'ValueDefinitions'.
		moduleBody add:
			(ViennaDefinitionBlockNode definition: valueDefinitions) ].
	ast module allDescendantsDo: [ :n |
		(ast sameAs: n) ifTrue: [
			self
				replaceNode: n
				with: (ViennaLocalNameNode identifier: self newName) ] ].
	valueDefinition := ViennaNode label: 'ValueDefinition' withAll: {
			                   (ViennaPatternIdentifierNode identifier:
				                    self newName).
			                   nil.
			                   ast }.
	accessValueDefinition := ViennaAccessValueDefinitionNode
		                         access: (ViennaNode label: 'Access')
		                         valueDefinition: valueDefinition.
	valueDefinitions add: accessValueDefinition.
	^ accessValueDefinition
]

{ #category : #accessing }
ViennaExtractValueAndReplaceAll >> name [

	^ 'Extract value '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' and Replace all' asText
]

{ #category : #accessing }
ViennaExtractValueAndReplaceAll >> sortingOrder [
	^ 2.54
]
