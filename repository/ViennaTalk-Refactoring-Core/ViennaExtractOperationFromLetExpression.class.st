Class {
	#name : #ViennaExtractOperationFromLetExpression,
	#superclass : #ViennaExtract,
	#instVars : [
		'freeIdentifiers'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> arguments [

	^ ViennaExpressionListNode withAll:
		  (ast first collect: [ :localDef | localDef first third ])
		  , (freeIdentifiers collect: [ :identifier |
				   ViennaLocalNameNode identifier: identifier ])
]

{ #category : #operations }
ViennaExtractOperationFromLetExpression >> check [

	| params |
	(ast notNil and: [ ast isViennaLetExpressionNode ]) ifFalse: [
		^ false ].
	params := ast localDefinitionList uniqueBoundIdentifiers
		          asOrderedCollection.
	ast localDefinitionList do: [ :localDef |
		localDef valueDefinitionOrFunctionDefinition expression
			allDescendantsDo: [ :node |
				(node isViennaLocalNameNode and: [
					 params includes: node identifier ]) ifTrue: [ ^ false ] ] ].
	^ true
]

{ #category : #operations }
ViennaExtractOperationFromLetExpression >> execute [

	| moduleBody operationDefinitions explicitOperationDefinition accessOperationDefinition |
	self newName ifNil: [ ^ self ].
	moduleBody := ast module third.
	operationDefinitions := (moduleBody
		                         detect: [ :definitionBlock |
			                         definitionBlock isViennaNode and: [
				                         definitionBlock first isViennaNode and: [
					                         definitionBlock first
						                         isViennaOperationDefinitionsNode ] ] ]
		                         ifNone: [ nil ]) ifNotNil: #first.
	operationDefinitions ifNil: [
		operationDefinitions := ViennaOperationDefinitionsNode empty.
		moduleBody add:
			(ViennaDefinitionBlockNode definition: operationDefinitions) ].
	freeIdentifiers := self ast uniqueFreeIdentifiers reject: [
		                   :identifier |
		                   (self ast resolveIdentifier: identifier)
			                   isViennaStateDefinitionNode ].
	self replaceNode: ast with: (ViennaApplyNode
			 expression: (ViennaLocalNameNode identifier: self newName)
			 argumentExpressionList: self arguments).
	explicitOperationDefinition := ViennaExplicitOperationDefinitionNode
		                               identifier: self newName
		                               type: self operationType
		                               parameters:
		                               self operationParametersList
		                               operationBody: self operationBody
		                               pre: nil
		                               post: nil.
	accessOperationDefinition := ViennaAccessOperationDefinitionNode
		                             access: ViennaAccessNode pure
		                             operationDefinition:
		                             (ViennaOperationDefinitionNode
			                              definition:
			                              explicitOperationDefinition).
	operationDefinitions add: accessOperationDefinition.
	^ accessOperationDefinition
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> findNewName [
	(UIManager default
		request: 'name of pure operation for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> name [

	^ 'Extract a pure operation '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from let expression ' asText
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> operationBody [

	^ ViennaOperationBodyNode statement:
		  (ViennaReturnStatementNode expression: ast second)
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> operationParametersList [

	^ ViennaParametersNode withAll:
		  (ast first collect: [ :localDef | localDef first first ])
		  , (freeIdentifiers collect: [ :identifier |
				   ViennaPatternIdentifierNode identifier: identifier ])
]

{ #category : #'parsers-types' }
ViennaExtractOperationFromLetExpression >> operationType [

	^ ViennaOperationTypeNode
		  argumentType:
			  ((self operationParametersList collect: [ :param |
				    ViennaBasicTypeNode any ])
				   ifNotEmpty: [ :paramTypes |
					   paramTypes size = 1
						   ifTrue: [ paramTypes first ]
						   ifFalse: [ ViennaProductTypeNode withAll: paramTypes ] ]
				   ifEmpty: [ ViennaUnitTypeNode new ])
		  returnType: ViennaBasicTypeNode any
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> sortingOrder [
	^ 2.56
]
