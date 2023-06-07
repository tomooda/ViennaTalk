Class {
	#name : #ViennaExtractOperationFromLetStatement,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> arguments [
	^ ViennaNode
		label: 'ExpressionList'
		withAll: (ast first collect: [ :localDef | localDef first third ])
]

{ #category : #operations }
ViennaExtractOperationFromLetStatement >> check [

	| params |
	ast isViennaLetStatementNode ifFalse: [ ^ false ].
	params := Set new: ast localDefinitionList size * 2.
	ast localDefinitionList do: [ :localDef |
		localDef first label = 'FunctionDefinition' ifTrue: [ ^ false ].
		localDef first first allDescendantsDo: [ :node |
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
					                         definitionBlock first label
					                         = 'OperationDefinitions' ] ] ]
		                         ifNone: [ nil ]) ifNotNil: #first.
	operationDefinitions ifNil: [
		operationDefinitions := ViennaNode label: 'OperationDefinitions'.
		moduleBody add:
			(ViennaNode label: 'DefinitionBlock' with: operationDefinitions) ].
	self replaceNode: ast with: (ViennaCallStatementNode
			 name: (ViennaLocalNameNode identifier: self newName)
			 expressionList: self arguments).
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
		                             with: (ViennaNode label: 'Access')
		                             with: (ViennaNode
				                              label: 'OperationDefinition'
				                              with: explicitOperationDefinition).
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
	^ ViennaNode
		label: 'Parameters'
		withAll: (ast first collect: [ :localDef | localDef first first ])
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
