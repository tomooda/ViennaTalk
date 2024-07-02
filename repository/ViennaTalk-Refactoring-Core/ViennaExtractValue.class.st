Class {
	#name : 'ViennaExtractValue',
	#superclass : 'ViennaExtract',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaExtractValue >> check [

	ast isViennaExpressionNode ifFalse: [ ^ false ].
	ast isViennaNameNode ifTrue: [ ^ false ].
	ast isRelocatable ifFalse: [ ^ false ].
	ast hasStatefulReference ifTrue: [ ^ false ].
	^ true
]

{ #category : 'operations' }
ViennaExtractValue >> execute [

	| module valueDefinition |
	self newName ifNil: [ ^ nil ].
	module := ast module.
	self
		replaceNode: ast
		with: (ViennaLocalNameNode identifier: self newName).
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
ViennaExtractValue >> findNewName [
	(UIManager default
		request: 'name of toplevel value for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaExtractValue >> name [

	^ 'Extract value '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
]

{ #category : 'accessing' }
ViennaExtractValue >> sortingOrder [
	^ 2.53
]
