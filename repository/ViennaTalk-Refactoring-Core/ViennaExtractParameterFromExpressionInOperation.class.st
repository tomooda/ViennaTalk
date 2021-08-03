Class {
	#name : #ViennaExtractParameterFromExpressionInOperation,
	#superclass : #ViennaExtractParameter,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaExtractParameterFromExpressionInOperation class >> isAbstract [
	^ self == ViennaExtractParameterFromExpressionInOperation
]

{ #category : #operations }
ViennaExtractParameterFromExpressionInOperation >> check [
	| moduleName shortName |
	ast ifNil: [ ^ false ].
	ast isExpressionNode
		ifFalse: [ ^ false ].
	ast variableExpressionNodesDo: [ :node | ^ false ].
	self definitionNode ifNil: [ ^ false ].
	moduleName := ast module first.
	shortName := self definitionNode first.
	ast
		modulesDo: [ :module | 
			module second first
				ifNotNil: [ :importDefinitionList | 
					importDefinitionList
						do: [ :importDefinition | 
							importDefinition first = moduleName
								ifTrue: [ importDefinition
										allDescendantsDo: [ :node | 
											(node label = 'OperationImport' and: [ node first = shortName ])
												ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaExtractParameterFromExpressionInOperation >> executeCallers [
	| moduleName shortName |
	moduleName := ast module first.
	shortName := self definitionNode first.
	ast module third
		allDescendantsDo: [ :node | 
			((#('Apply' 'CallStatement') includes: node label)
				and: [ (node first label = 'LocalName'
						and: [ node first first = shortName ])
						or: [ node first label = 'GlobalName'
								and:
									[ node first first = moduleName and: [ node first second = shortName ] ] ] ])
				ifTrue: [ node second add: ast copyFragment ] ]
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInOperation >> name [
	^ 'Extract parameter from ' asText
		, (self shortDescription: ast source) asText allBold
		, ' in operation ' asText , self definitionNode first asText allBold
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInOperation >> sortingOrder [
	^ 2.181
]
