Class {
	#name : 'ViennaConvertExplicitFunctionIntoOperation',
	#superclass : 'ViennaRefactoring',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaConvertExplicitFunctionIntoOperation >> check [

	^ ast isViennaNode and: [ ast isViennaExplicitFunctionDefinitionNode ]
]

{ #category : 'operations' }
ViennaConvertExplicitFunctionIntoOperation >> execute [

	| module explicitOperationDefinition |
	module := ast module.
	explicitOperationDefinition := ViennaExplicitOperationDefinitionNode
		                               access:
		                               (ViennaAccessNode withAll:
			                                (ast access asArray copyWith:
				                                 'pure'))
		                               identifier: ast identifier
		                               type: (ViennaOperationTypeNode
				                                argumentType:
				                                ast type argumentType
				                                returnType: ast type returnType)
		                               parameters: ast parametersList first
		                               statement:
		                               (ViennaReturnStatementNode
			                                expression: ast expression)
		                               pre: ast pre
		                               post: ast post.
	self removeOperationDefinition: ast.
	self addOperationDefinition: explicitOperationDefinition in: module.
	^ explicitOperationDefinition
]

{ #category : 'accessing' }
ViennaConvertExplicitFunctionIntoOperation >> name [

	^ 'Convert ' asText
	  , (self shortDescription: ast identifier) asText allBold
	  , ' into a pure operation' asText
]

{ #category : 'accessing' }
ViennaConvertExplicitFunctionIntoOperation >> sortingOrder [
	^ 2.51
]
