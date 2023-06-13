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
					                    definitionBlock first label
					                    = 'TypeDefinitions' ] ] ]
		                    ifNone: [ nil ]) ifNotNil: #first.
	typeDefinitions ifNil: [
		typeDefinitions := ViennaNode label: 'TypeDefinitions'.
		moduleBody add:
			(ViennaNode label: 'DefinitionBlock' with: typeDefinitions) ].
	ast module allDescendantsDo: [ :n |
		(ast sameAs: n) ifTrue: [
			self replaceNode: n with: (ViennaTypeNameNode name:
					 (ViennaLocalNameNode identifier: self newName)) ] ].
	typeDefinition := ViennaNode
		                  label: 'TypeDefinition'
		                  with: self newName
		                  with: ast
		                  with: nil.
	accessTypeDefinition := ViennaAccessTypeDefinitionNode
		                        access: (ViennaNode label: 'Access')
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
