Class {
	#name : #ViennaConvertExplicitFunctionIntoOperation,
	#superclass : #ViennaRefactoring,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaConvertExplicitFunctionIntoOperation >> check [

	^ ast isViennaNode and: [
		  ast isViennaAccessFunctionDefinitionNode and: [
			  ast functionDefinition isViennaNode and: [
				  ast functionDefinition label = 'FunctionDefinition' and: [
					  ast functionDefinition first
						  isViennaExplicitFunctionDefinitionNode ] ] ] ]
]

{ #category : #operations }
ViennaConvertExplicitFunctionIntoOperation >> execute [

	| functionDefinition explicitFunctionDefinition functionDefinitions moduleBody operationDefinitions explicitOperationDefinition accessOperationDefinition |
	functionDefinition := ast second.
	explicitFunctionDefinition := functionDefinition first.
	functionDefinitions := ast parent.
	moduleBody := functionDefinitions parent parent.
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
			(ViennaDefinitionBlockNode definition: operationDefinitions) ].
	explicitOperationDefinition := ViennaExplicitOperationDefinitionNode
		                               identifier:
		                               explicitFunctionDefinition identifier
		                               type: (ViennaOperationTypeNode
				                                argumentType:
				                                explicitFunctionDefinition type
					                                argumentType
				                                returnType:
				                                explicitFunctionDefinition type
					                                returnType)
		                               parameters:
		                               explicitFunctionDefinition
			                               parametersList first
		                               operationBody:
			                               (ViennaOperationBodyNode statement:
				                                (ViennaReturnStatementNode
					                                 expression:
					                                 explicitFunctionDefinition sixth))
		                               pre:
		                               explicitFunctionDefinition seventh
		                               post:
		                               explicitFunctionDefinition eighth.
	accessOperationDefinition := ViennaAccessOperationDefinitionNode
		                             access: (ViennaNode
				                              label: 'Access'
				                              withAll:
				                              (ast first asArray copyWith: 'pure'))
		                             operationDefinition: (ViennaNode
				                              label: 'OperationDefinition'
				                              with: explicitOperationDefinition).
	functionDefinitions remove: ast.
	functionDefinitions ifEmpty: [
		moduleBody remove: functionDefinitions parent ].
	operationDefinitions add: accessOperationDefinition.
	^ accessOperationDefinition
]

{ #category : #accessing }
ViennaConvertExplicitFunctionIntoOperation >> name [
	^ 'Convert ' asText
		, (self shortDescription: ast second first first) asText allBold
		, ' into a pure operation' asText
]

{ #category : #accessing }
ViennaConvertExplicitFunctionIntoOperation >> sortingOrder [
	^ 2.51
]
