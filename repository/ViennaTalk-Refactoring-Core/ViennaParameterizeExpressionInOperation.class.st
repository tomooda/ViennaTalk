Class {
	#name : #ViennaParameterizeExpressionInOperation,
	#superclass : #ViennaParameterize,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaParameterizeExpressionInOperation class >> isAbstract [
	^ self == ViennaParameterizeExpressionInOperation
]

{ #category : #operations }
ViennaParameterizeExpressionInOperation >> check [
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
ViennaParameterizeExpressionInOperation >> executeCallers [
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
ViennaParameterizeExpressionInOperation >> name [
	^ 'Parameterize ' asText , ast source asText allBold , ' in operation ' asText
		, self definitionNode first asText allBold
]

{ #category : #accessing }
ViennaParameterizeExpressionInOperation >> sortingOrder [
	^ 2.181
]
