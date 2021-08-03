Class {
	#name : #ViennaExtractStateVariable,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractStateVariable >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	ast variableExpressionNodesDo: [ :node | ^ false ].
	ast parent label = 'ValueDefinition'
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractStateVariable >> execute [
	| moduleBody stateDefinition fieldList initializer |
	self newName ifNil: [ ^ nil ].
	moduleBody := ast module third.
	stateDefinition := moduleBody
		detect: [ :definitionBlock | 
			definitionBlock isViennaNode
				and: [ definitionBlock first isViennaNode
						and: [ definitionBlock first label = 'StateDefinition' ] ] ]
		ifNone: [ nil ].
	stateDefinition
		ifNil: [ stateDefinition := ViennaNode
				label: 'StateDefinition'
				with: 'State'
				with: (ViennaNode label: 'FieldList')
				with: nil
				with:
					(ViennaNode
						label: 'Initialisation'
						with:
							(ViennaNode
								label: 'InvariantInitialFunction'
								with: (ViennaNode label: 'PatternIdentifier' with: 's')
								with:
									(ViennaNode
										label: 'Equal'
										with: (ViennaNode label: 'LocalName' with: 's')
										with:
											(ViennaNode
												label: 'RecordConstructor'
												with: (ViennaNode label: 'LocalName' with: 'State')
												with: (ViennaNode label: 'ExpressionList'))))).
			moduleBody
				add: (ViennaNode label: 'DefinitionBlock' with: stateDefinition) ].
	self
		replaceNode: ast
		with: (ViennaNode label: 'LocalName' with: self newName).
	fieldList := stateDefinition second.
	fieldList
		add:
			(ViennaNode
				label: 'Field'
				with: self newName
				with: false
				with: (ViennaNode label: 'BasicType' with: 'any')).
	initializer := stateDefinition fourth first second second second.
	initializer add: ast
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
	^ 'Extract ' asText
		, (self shortDescription: ast source) asText allBold
		, ' as a state variable' asText
]

{ #category : #accessing }
ViennaExtractStateVariable >> sortingOrder [
	^ 2.54
]
