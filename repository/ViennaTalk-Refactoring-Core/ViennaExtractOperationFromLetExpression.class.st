Class {
	#name : #ViennaExtractOperationFromLetExpression,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> arguments [
	^ ViennaNode
		label: 'ExpressionList'
		withAll: (ast first collect: [ :localDef | localDef first third ])
]

{ #category : #operations }
ViennaExtractOperationFromLetExpression >> check [

	| params |
	ast isViennaLetExpressionNode ifFalse: [ ^ false ].
	params := Set new: ast first size * 2.
	ast first do: [ :localDef |
		localDef first label = 'FunctionDefinition' ifTrue: [ ^ false ].
		localDef first first allDescendantsDo: [ :node |
			node isViennaPatternIdentifierNode ifTrue: [
				params add: node first ] ] ].
	ast first do: [ :localDef |
		localDef first third allDescendantsDo: [ :node |
			(node isViennaLocalNameNode and: [
				 params includes: node identifier ]) ifTrue: [ ^ false ] ] ].
	ast second variableExpressionNodesDo: [ :node |
		node isStateVariableNameNode ifFalse: [ ^ false ] ].
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
					                         definitionBlock first label
					                         = 'OperationDefinitions' ] ] ]
		                         ifNone: [ nil ]) ifNotNil: #first.
	operationDefinitions ifNil: [
		operationDefinitions := ViennaNode label: 'OperationDefinitions'.
		moduleBody add:
			(ViennaNode label: 'DefinitionBlock' with: operationDefinitions) ].
	self replaceNode: ast with: (ViennaApplyNode
			 expression: (ViennaLocalNameNode identifier: self newName)
			 argumentExpressionList: self arguments).
	explicitOperationDefinition := ViennaNode
		                               label: 'ExplicitOperationDefinition'
		                               withAll: {
				                               self newName.
				                               self operationType.
				                               self newName.
				                               self operationParametersList.
				                               self operationBody.
				                               nil.
				                               nil }.
	accessOperationDefinition := ViennaNode
		                             label: 'AccessOperationDefinition'
		                             with:
		                             (ViennaNode
			                              label: 'Access'
			                              with: 'pure')
		                             with: (ViennaNode
				                              label: 'OperationDefinition'
				                              with: explicitOperationDefinition).
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
	^ ViennaNode
		label: 'Parameters'
		withAll: (ast first collect: [ :localDef | localDef first first ])
]

{ #category : #'parsers-types' }
ViennaExtractOperationFromLetExpression >> operationType [
	^ ViennaNode
		label: 'OperationType'
		with:
			((ast first
				collect: [ :localDef | ViennaNode label: 'BasicType' with: 'any' ])
				ifNotEmpty: [ :paramTypes | 
					paramTypes size = 1
						ifTrue: [ paramTypes first ]
						ifFalse: [ ViennaNode label: 'ProductType' withAll: paramTypes ] ]
				ifEmpty: [ ViennaNode label: 'UnitType' ])
		with: (ViennaNode label: 'BasicType' with: 'any')
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpression >> sortingOrder [
	^ 2.56
]
