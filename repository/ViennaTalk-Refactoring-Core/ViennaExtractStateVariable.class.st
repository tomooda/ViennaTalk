Class {
	#name : #ViennaExtractStateVariable,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractStateVariable >> check [

	ast isViennaExpressionNode ifFalse: [ ^ false ].
	ast hasStatefulReference ifTrue: [ ^ false ].
	(ast detectParent: #isViennaValueDefinitionNode ifNone: [ nil ])
		ifNotNil: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractStateVariable >> execute [

	| module stateDefinition |
	self newName ifNil: [ ^ nil ].
	module := ast module.
	stateDefinition := module stateDefinitionIfAbsentPut: [
		                   ViennaStateDefinitionNode empty ].
	self
		replaceNode: ast
		with: (ViennaLocalNameNode identifier: self newName).
	stateDefinition fieldList add: (ViennaFieldNode
			 identifier: self newName
			 equalityAbstraction: false
			 type: ViennaBasicTypeNode any).
	stateDefinition init invariantInitialFunction expression expression2
		expressionList add: ast.
	stateDefinition inv ifNotNil: [ :invariant |
		invariant invariantInitialFunction pattern isViennaRecordPatternNode
			ifTrue: [
				invariant invariantInitialFunction pattern patternList add:
					ViennaPatternIdentifierNode anonymous ] ].
	^ stateDefinition
]

{ #category : #accessing }
ViennaExtractStateVariable >> findNewName [
	(UIManager default
		request: 'name of state variable for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractStateVariable >> name [

	^ 'Extract state variable '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractStateVariable >> sortingOrder [
	^ 2.54
]
