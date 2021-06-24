Class {
	#name : #ViennaParameterizeExpressionInFunction,
	#superclass : #ViennaParameterize,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaParameterizeExpressionInFunction class >> isAbstract [
	^ self == ViennaParameterizeExpressionInFunction
]

{ #category : #operations }
ViennaParameterizeExpressionInFunction >> check [
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
											(node label = 'FunctionImport' and: [ node first = shortName ])
												ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaParameterizeExpressionInFunction >> executeCallers [
	| moduleName shortName |
	moduleName := ast module first.
	shortName := self definitionNode first.
	ast module third
		allDescendantsDo: [ :node | 
			(node label = 'Apply'
				and: [ (node first label = 'LocalName'
						and: [ node first first = shortName ])
						or: [ node first label = 'GlobalName'
								and:
									[ node first first = moduleName and: [ node first second = shortName ] ] ] ])
				ifTrue: [ node second add: ast copyFragment ] ]
]

{ #category : #accessing }
ViennaParameterizeExpressionInFunction >> name [
	^ 'Parameterize ' asText , ast source asText allBold , ' in function ' asText
		, self definitionNode first asText allBold
]

{ #category : #accessing }
ViennaParameterizeExpressionInFunction >> sortingOrder [
	^ 2.183
]
