Class {
	#name : #ViennaExtractFunctionFromLetExpression,
	#superclass : #ViennaExtract,
	#instVars : [
		'freeIdentifiers'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> arguments [

	^ ViennaExpressionListNode withAll:
		  (ast localDefinitionList collect: [ :localDef |
			   localDef expression ])
		  , (freeIdentifiers collect: [ :identifier |
				   ViennaLocalNameNode identifier: identifier ])
]

{ #category : #operations }
ViennaExtractFunctionFromLetExpression >> check [

	| params |
	(ast notNil and: [ ast isViennaLetExpressionNode ]) ifFalse: [
		^ false ].
	ast expression hasStatefulReference ifTrue: [ ^ false ].
	params := ast localDefinitionList uniqueBoundIdentifiers
		          asOrderedCollection.
	ast localDefinitionList do: [ :localDef |
		localDef expression allDescendantsDo: [ :node |
			(node isViennaLocalNameNode and: [
				 params includes: node identifier ]) ifTrue: [ ^ false ] ] ].
	^ true
]

{ #category : #operations }
ViennaExtractFunctionFromLetExpression >> execute [

	| module explicitFunctionDefinition |
	module := self ast module.
	self newName ifNil: [ ^ self ].
	freeIdentifiers := self ast uniqueFreeIdentifiers.
	self replaceNode: ast with: (ViennaApplyNode
			 expression: (ViennaLocalNameNode identifier: self newName)
			 argumentExpressionList: self arguments).
	explicitFunctionDefinition := ViennaExplicitFunctionDefinitionNode
		                              identifier: self newName
		                              typeVariableList:
		                              ViennaTypeVariableListNode empty
		                              type: self functionType
		                              parametersList:
		                              self functionParametersList
		                              expression: self functionBody
		                              pre: nil
		                              post: nil
		                              measure: nil.
	self addFunctionDefinition: explicitFunctionDefinition in: module.
	^ explicitFunctionDefinition
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> findNewName [
	(UIManager default
		request: 'name of toplevel function for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> functionBody [
	^ ast second
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> functionParametersList [

	^ ViennaParametersListNode with: (ViennaParametersNode withAll:
			   (ast localDefinitionList collect: [ :localDef |
				    localDef pattern ])
			   , (freeIdentifiers collect: [ :identifier |
					    ViennaPatternIdentifierNode identifier: identifier ]))
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> functionType [

	^ ViennaPartialFunctionTypeNode
		  argumentType:
			  ((self functionParametersList first collect: [ :param |
				    ViennaBasicTypeNode any ])
				   ifNotEmpty: [ :paramTypes |
					   paramTypes size = 1
						   ifTrue: [ paramTypes first ]
						   ifFalse: [ ViennaProductTypeNode withAll: paramTypes ] ]
				   ifEmpty: [ ViennaUnitTypeNode new ])
		  returnType: ViennaBasicTypeNode any
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> name [

	^ 'Extract function '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from let expression' asText
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> sortingOrder [
	^ 2.55
]
