Class {
	#name : #ViennaExtractParameterFromExpressionInFunction,
	#superclass : #ViennaExtractParameter,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaExtractParameterFromExpressionInFunction class >> isAbstract [
	^ self == ViennaExtractParameterFromExpressionInFunction
]

{ #category : #operations }
ViennaExtractParameterFromExpressionInFunction >> check [
	| moduleName shortName |
	ast ifNil: [ ^ false ].
	ast isViennaExpressionNode
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
ViennaExtractParameterFromExpressionInFunction >> executeCallers [

	| moduleName shortName |
	moduleName := ast module first.
	shortName := self definitionNode first.
	ast module third allDescendantsDo: [ :node |
		(node isViennaApplyNode and: [
			 (node expression label = 'LocalName' and: [
				  node expression first = shortName ]) or: [
				 node expression label = 'GlobalName' and: [
					 node expression first = moduleName and: [
						 node expression second = shortName ] ] ] ]) ifTrue: [
			node argumentExpressionList add: ast copyFragment ] ]
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInFunction >> name [

	^ 'Extract parameter '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' in function ' asText , self definitionNode first asText allBold
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInFunction >> sortingOrder [
	^ 2.183
]
