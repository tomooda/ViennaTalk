Class {
	#name : #ViennaExtractOperationFromLetExpression,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> arguments [

	^ ViennaExpressionListNode withAll:
		  (ast first collect: [ :localDef | localDef first third ])
]

{ #category : #operations }
ViennaExtractOperationFromLetExpression >> check [

	| params |
	ast isViennaLetExpressionNode ifFalse: [ ^ false ].
	params := Set new: ast first size * 2.
	ast first do: [ :localDef |
		localDef first isViennaFunctionDefinitionNode ifTrue: [ ^ false ].
		localDef first definition allDescendantsDo: [ :node |
			node isViennaPatternIdentifierNode ifTrue: [
				params add: node first ] ] ].
	ast first do: [ :localDef |
		localDef first third allDescendantsDo: [ :node |
			(node isViennaLocalNameNode and: [
				 params includes: node identifier ]) ifTrue: [ ^ false ] ] ].
	ast second isRelocatable ifFalse: [ ^ false ].
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

	^ ViennaReturnStatementNode expression: ast second
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> operationParametersList [

	^ ViennaParametersNode withAll:
		  (ast first collect: [ :localDef | localDef first first ])
]

{ #category : #'parsers-types' }
ViennaExtractOperationFromLetExpression >> operationType [

	^ ViennaOperationTypeNode
		  argumentType:
			  ((ast first collect: [ :localDef | ViennaBasicTypeNode any ])
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
