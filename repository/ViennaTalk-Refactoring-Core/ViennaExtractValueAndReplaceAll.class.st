Class {
	#name : 'ViennaExtractValueAndReplaceAll',
	#superclass : 'ViennaExtractValue',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaExtractValueAndReplaceAll >> execute [

	| module valueDefinition |
	self newName ifNil: [ ^ self ].
	module := ast module.
	ast module allDescendantsDo: [ :n |
		ast = n ifTrue: [
			self
				replaceNode: n
				with: (ViennaLocalNameNode identifier: self newName) ] ].
	valueDefinition := ViennaValueDefinitionNode
		                   pattern:
		                   (ViennaPatternIdentifierNode identifier:
			                    self newName)
		                   type: nil
		                   expression: ast.
	self addValueDefinition: valueDefinition in: module.
	^ valueDefinition
]

{ #category : 'accessing' }
ViennaExtractValueAndReplaceAll >> name [

	^ 'Extract value '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' and Replace all' asText
]

{ #category : 'accessing' }
ViennaExtractValueAndReplaceAll >> sortingOrder [
	^ 2.54
]
