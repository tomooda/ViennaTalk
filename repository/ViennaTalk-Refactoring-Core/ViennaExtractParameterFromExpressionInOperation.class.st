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

	| moduleIdentifier identifier |
	ast ifNil: [ ^ false ].
	ast isViennaExpressionNode ifFalse: [ ^ false ].
	ast hasStatefulReference ifTrue: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	moduleIdentifier := ast module identifier.
	identifier := self definitionNode identifier.
	ast modulesDo: [ :module |
		(module importsFrom: moduleIdentifier identifier: identifier)
			ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #operations }
ViennaExtractParameterFromExpressionInOperation >> executeCallers [

	| moduleName shortName globalName localName |
	moduleName := ast module identifier.
	shortName := self definitionNode identifier.
	globalName := ViennaGlobalNameNode
		              moduleIdentifier: moduleName
		              identifier: shortName.
	localName := ViennaLocalNameNode identifier: shortName.
	ast module third allDescendantsDo: [ :node |
		(node isViennaApplyNode and: [
			 node expression = globalName or: [ node expression = localName ] ])
			ifTrue: [ node argumentExpressionList add: ast copyFragment ].
		(node isViennaCallStatementNode and: [
			 node first = globalName or: [ node first = localName ] ]) ifTrue: [
			node second add: ast copyFragment ] ]
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInOperation >> name [

	^ 'Extract parameter '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' in operation ' asText
	  , self definitionNode identifier asText allBold
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInOperation >> sortingOrder [
	^ 2.181
]
