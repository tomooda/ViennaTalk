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
					  ast functionDefinition first label
					  = 'ExplicitFunctionDefinition' ] ] ] ]
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
			(ViennaNode label: 'DefinitionBlock' with: operationDefinitions) ].
	explicitOperationDefinition := ViennaNode
		                               label: 'ExplicitOperationDefinition'
		                               withAll: {
				                               explicitFunctionDefinition first.
				                               (ViennaOperationTypeNode
					                                argumentType:
					                                explicitFunctionDefinition third
						                                first
					                                returnType:
					                                explicitFunctionDefinition third
						                                second).
				                               explicitFunctionDefinition fourth.
				                               explicitFunctionDefinition fifth
					                               first.
				                               (ViennaOperationBodyNode
					                                statement:
						                                (ViennaReturnStatementNode
							                                 expression:
							                                 explicitFunctionDefinition
								                                 sixth)).
				                               explicitFunctionDefinition seventh.
				                               explicitFunctionDefinition eighth }.
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
