Class {
	#name : 'ViennaExtractTypeAndReplaceAll',
	#superclass : 'ViennaExtractType',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaExtractTypeAndReplaceAll >> execute [

	| module typeDefinition |
	self newName ifNil: [ ^ self ].
	module := ast module.
	ast module allDescendantsDo: [ :n |
		ast = n ifTrue: [
			self replaceNode: n with: (ViennaTypeNameNode name:
					 (ViennaLocalNameNode identifier: self newName)) ] ].
	typeDefinition := ViennaTypeSynonymNode
		                  identifier: self newName
		                  type: ast
		                  inv: nil.
	self addTypeDefinition: typeDefinition in: module.
	^ typeDefinition
]

{ #category : 'accessing' }
ViennaExtractTypeAndReplaceAll >> name [

	^ 'Extract type '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' and Replace all' asText
]

{ #category : 'accessing' }
ViennaExtractTypeAndReplaceAll >> sortingOrder [
	^ 2.52
]
