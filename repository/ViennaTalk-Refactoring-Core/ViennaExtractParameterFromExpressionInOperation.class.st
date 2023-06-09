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
	ast isViennaExpressionNode ifFalse: [ ^ false ].
	ast variableExpressionNodesDo: [ :node | ^ false ].
	self definitionNode ifNil: [ ^ false ].
	moduleName := ast module identifier.
	shortName := self definitionNode identifier.
	ast modulesDo: [ :module |
		module second first ifNotNil: [ :importDefinitionList |
			importDefinitionList do: [ :importDefinition |
				importDefinition first = moduleName ifTrue: [
					importDefinition allDescendantsDo: [ :node |
						(node isViennaOperationImportNode: shortName) ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaExtractParameterFromExpressionInOperation >> executeCallers [

	| moduleName shortName globalName localName |
	moduleName := ast module first.
	shortName := self definitionNode first.
	globalName := ViennaGlobalNameNode
		              moduleIdentifier: moduleName
		              identifier: shortName.
	localName := ViennaLocalNameNode identifier: shortName.
	ast module third allDescendantsDo: [ :node |
		(node isViennaApplyNode and: [
			 (node expression sameAs: globalName) or: [
				 node expression sameAs: localName ] ]) ifTrue: [
			node argumentExpressionList add: ast copyFragment ].
		(node isViennaCallStatementNode and: [
			 (node first sameAs: globalName) or: [
				 node first sameAs: localName ] ]) ifTrue: [
			node second add: ast copyFragment ] ]
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInOperation >> name [

	^ 'Extract parameter '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' in operation ' asText
	  , self definitionNode first asText allBold
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInOperation >> sortingOrder [
	^ 2.181
]
