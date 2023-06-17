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
				  ast functionDefinition isViennaFunctionDefinitionNode and: [
					  ast functionDefinition first
						  isViennaExplicitFunctionDefinitionNode ] ] ] ]
]

{ #category : #operations }
ViennaConvertExplicitFunctionIntoOperation >> execute [

	| functionDefinition explicitFunctionDefinition functionDefinitions moduleBody operationDefinitions explicitOperationDefinition accessOperationDefinition |
	functionDefinition := ast functionDefinition.
	explicitFunctionDefinition := functionDefinition definition.
	functionDefinitions := ast parent.
	moduleBody := functionDefinitions parent parent.
	operationDefinitions := (moduleBody
		                         detect: [ :definitionBlock |
			                         definitionBlock isViennaNode and: [
				                         definitionBlock definition isViennaNode
					                         and: [
					                         definitionBlock definition
						                         isViennaOperationDefinitionsNode ] ] ]
		                         ifNone: [ nil ]) ifNotNil: #definition.
	operationDefinitions ifNil: [
		operationDefinitions := ViennaOperationDefinitionsNode empty.
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
					                                 explicitFunctionDefinition
						                                 expression))
		                               pre: explicitFunctionDefinition pre
		                               post: explicitFunctionDefinition post.
	accessOperationDefinition := ViennaAccessOperationDefinitionNode
		                             access:
		                             (ViennaAccessNode withAll:
			                              (ast access asArray copyWith: 'pure'))
		                             operationDefinition:
		                             (ViennaOperationDefinitionNode
			                              definition:
			                              explicitOperationDefinition).
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
