Class {
	#name : #ViennaConvertExplicitFunctionIntoOperation,
	#superclass : #ViennaRefactoring,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaConvertExplicitFunctionIntoOperation >> check [
	^ ast isViennaNode
		and: [ ast label = 'AccessFunctionDefinition'
				and: [ ast second isViennaNode
						and: [ ast second label = 'ExplicitFunctionDefinition' ] ] ]
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
			definitionBlock isViennaNode
				and: [ definitionBlock first isViennaNode
						and: [ definitionBlock first label = 'OperationDefinitions' ] ] ]
		ifNone: [ nil ]) ifNotNil: #first.
	operationDefinitions
		ifNil: [ operationDefinitions := ViennaNode label: 'OperationDefinitions'.
			moduleBody add: operationDefinitions ].
	explicitOperationDefinition := ViennaNode
		label: 'ExplicitOperationDefinition'
		withAll:
			{explicitFunctionDefinition first.
			(ViennaNode
				label: 'OperationType'
				with: explicitFunctionDefinition third first
				with: explicitFunctionDefinition third second).
			explicitFunctionDefinition fourth.
			explicitFunctionDefinition fifth first.
			(ViennaNode
				label: 'OperationBody'
				with:
					(ViennaNode
						label: 'ReturnStatement'
						with: explicitFunctionDefinition sixth)).
			explicitFunctionDefinition seventh.
			explicitFunctionDefinition eighth}.
	accessOperationDefinition := ViennaNode
		label: 'AccessOperationDefinition'
		with:
			(ViennaNode
				label: 'Access'
				withAll: (ast first asArray copyWith: 'pure'))
		with:
			(ViennaNode
				label: 'OperationDefinition'
				with: explicitOperationDefinition).
	functionDefinitions remove: ast.
	functionDefinitions
		ifEmpty: [ moduleBody remove: functionDefinitions parent ].
	operationDefinitions add: accessOperationDefinition
]
