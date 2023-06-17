Class {
	#name : #ViennaExtractOperationFromLetStatement,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> arguments [

	^ ViennaExpressionListNode withAll:
		  (ast first collect: [ :localDef | localDef first third ])
]

{ #category : #operations }
ViennaExtractOperationFromLetStatement >> check [

	| params |
	ast isViennaLetStatementNode ifFalse: [ ^ false ].
	params := Set new: ast localDefinitionList size * 2.
	ast localDefinitionList do: [ :localDef |
		localDef first isViennaFunctionDefinitionNode ifTrue: [ ^ false ].
		localDef first definition allDescendantsDo: [ :node |
			node isViennaPatternIdentifierNode ifTrue: [
				params add: node first ] ] ].
	ast localDefinitionList do: [ :localDef |
		localDef first third allDescendantsDo: [ :node |
			(node isViennaLocalNameNode and: [
				 params includes: node identifier ]) ifTrue: [ ^ false ] ] ].
	ast statement variableExpressionNodesDo: [ :node |
		node isStateVariableNameNode ifFalse: [ ^ false ] ].
	ast statement allDescendantsDo: [ :node |
		node isViennaReturnStatementNode ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #operations }
ViennaExtractOperationFromLetStatement >> execute [

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
	self replaceNode: ast with: (ViennaCallStatementNode
			 name: (ViennaLocalNameNode identifier: self newName)
			 expressionList: self arguments).
	explicitOperationDefinition := ViennaExplicitOperationDefinitionNode
		                               identifier: self newName
		                               type: self operationType
		                               parameters:
		                               self operationParametersList
		                               operationBody: self operationBody
		                               pre: nil
		                               post: nil.
	accessOperationDefinition := ViennaAccessOperationDefinitionNode
		                             access: ViennaAccessNode empty
		                             operationDefinition:
		                             (ViennaOperationDefinitionNode
			                              definition:
			                              explicitOperationDefinition).
	operationDefinitions add: accessOperationDefinition.
	^ accessOperationDefinition
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> findNewName [
	(UIManager default
		request: 'name of operation for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> name [

	^ 'Extract an operation '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from let statement ' asText
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> newName: aString [
	newName := aString
]

{ #category : #'parsers-definitions' }
ViennaExtractOperationFromLetStatement >> operationBody [
	^ ast second
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> operationParametersList [

	^ ViennaParametersNode withAll:
		  (ast first collect: [ :localDef | localDef first first ])
]

{ #category : #'parsers-types' }
ViennaExtractOperationFromLetStatement >> operationType [

	^ ViennaOperationTypeNode
		  argumentType:
			  ((ast first collect: [ :localDef | ViennaBasicTypeNode any ])
				   ifNotEmpty: [ :paramTypes |
					   paramTypes size = 1
						   ifTrue: [ paramTypes first ]
						   ifFalse: [ ViennaProductTypeNode withAll: paramTypes ] ]
				   ifEmpty: [ ViennaUnitTypeNode new ])
		  returnType: ViennaUnitTypeNode new
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> sortingOrder [
	^ 2.57
]
