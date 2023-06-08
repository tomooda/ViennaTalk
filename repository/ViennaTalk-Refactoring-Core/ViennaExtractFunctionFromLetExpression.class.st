Class {
	#name : #ViennaExtractFunctionFromLetExpression,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> arguments [
	^ ViennaNode
		label: 'ExpressionList'
		withAll: (ast first collect: [ :localDef | localDef first third ])
]

{ #category : #operations }
ViennaExtractFunctionFromLetExpression >> check [

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
	ast second variableExpressionNodesDo: [ :node | ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractFunctionFromLetExpression >> execute [

	| moduleBody functionDefinitions explicitFunctionDefinition accessFunctionDefinition |
	self newName ifNil: [ ^ self ].
	moduleBody := ast module third.
	functionDefinitions := (moduleBody
		                        detect: [ :definitionBlock |
			                        definitionBlock isViennaNode and: [
				                        definitionBlock first isViennaNode and: [
					                        definitionBlock first label
					                        = 'FunctionDefinitions' ] ] ]
		                        ifNone: [ nil ]) ifNotNil: #first.
	functionDefinitions ifNil: [
		functionDefinitions := ViennaNode label: 'FunctionDefinitions'.
		moduleBody add:
			(ViennaNode label: 'DefinitionBlock' with: functionDefinitions) ].
	self replaceNode: ast with: (ViennaApplyNode
			 expression: (ViennaLocalNameNode identifier: self newName)
			 argumentExpressionList: self arguments).
	explicitFunctionDefinition := ViennaNode
		                              label: 'ExplicitFunctionDefinition'
		                              withAll: {
				                              self newName.
				                              ViennaTypeVariableListNode empty.
				                              self functionType.
				                              self newName.
				                              self functionParametersList.
				                              self functionBody.
				                              nil.
				                              nil.
				                              nil }.
	accessFunctionDefinition := ViennaNode
		                            label: 'AccessFunctionDefinition'
		                            with: (ViennaNode label: 'Access')
		                            with: (ViennaNode
				                             label: 'FunctionDefinition'
				                             with: explicitFunctionDefinition).
	functionDefinitions add: accessFunctionDefinition.
	^ accessFunctionDefinition
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

	^ ViennaParametersListNode withAll: { (ViennaParametersNode withAll:
			   (ast first collect: [ :localDef | localDef first first ])) }
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpression >> functionType [

	^ ViennaPartialFunctionTypeNode
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
