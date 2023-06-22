Class {
	#name : #ViennaExtractStateVariable,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractStateVariable >> check [

	ast isViennaExpressionNode ifFalse: [ ^ false ].
	ast hasStatefulReference ifTrue: [ ^ false ].
	ast parent isViennaValueDefinitionNode ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractStateVariable >> execute [

	| moduleBody stateDefinition fieldList initializer |
	self newName ifNil: [ ^ nil ].
	moduleBody := ast module third.
	stateDefinition := (moduleBody
		                    detect: [ :definitionBlock |
			                    definitionBlock isViennaNode and: [
				                    definitionBlock definition isViennaNode and: [
					                    definitionBlock definition
						                    isViennaStateDefinitionNode ] ] ]
		                    ifNone: [ nil ]) ifNotNil: #definition.
	self
		replaceNode: ast
		with: (ViennaLocalNameNode identifier: self newName).
	stateDefinition ifNil: [
		stateDefinition := ViennaStateDefinitionNode
			                   identifier: 'State'
			                   fieldList: ViennaFieldListNode empty
			                   inv: nil
			                   init:
				                   (ViennaInitialisationNode
					                    invariantInitialFunction:
						                    (ViennaInvariantInitialFunctionNode
							                     pattern:
							                     (ViennaPatternIdentifierNode identifier:
								                      's')
							                     expression: (ViennaEqualNode
									                      expression:
									                      (ViennaLocalNameNode identifier: 's')
									                      expression:
										                      (ViennaRecordConstructorNode
											                       name:
											                       (ViennaLocalNameNode identifier:
												                        'State')
											                       expressionList:
											                       ViennaExpressionListNode empty)))).
		moduleBody add:
			(ViennaDefinitionBlockNode definition: stateDefinition) ].
	fieldList := stateDefinition second.
	fieldList add: (ViennaFieldNode
			 identifier: self newName
			 equalityAbstraction: false
			 type: ViennaBasicTypeNode any).
	initializer := stateDefinition fourth first second second second.
	initializer add: ast.
	stateDefinition third ifNotNil: [ :invariant |
		invariant first first isViennaRecordPatternNode ifTrue: [
			invariant first first second add:
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
