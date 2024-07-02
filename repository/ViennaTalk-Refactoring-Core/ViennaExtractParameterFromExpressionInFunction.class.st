Class {
	#name : 'ViennaExtractParameterFromExpressionInFunction',
	#superclass : 'ViennaExtractParameter',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaExtractParameterFromExpressionInFunction class >> isAbstract [
	^ self == ViennaExtractParameterFromExpressionInFunction
]

{ #category : 'operations' }
ViennaExtractParameterFromExpressionInFunction >> check [

	| moduleName identifier |
	ast ifNil: [ ^ false ].
	ast isViennaExpressionNode ifFalse: [ ^ false ].
	ast hasStatefulReference ifTrue: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	moduleName := ast module identifier.
	identifier := self definitionNode identifier.
	ast modulesDo: [ :module |
		(module importsFrom: moduleName identifier: identifier) ifTrue: [
			^ false ] ].
	^ true
]

{ #category : 'operations' }
ViennaExtractParameterFromExpressionInFunction >> executeCallers [

	| moduleName shortName |
	moduleName := ast module identifier.
	shortName := self definitionNode identifier.
	ast module moduleBody
		allDescendantsSuchThat: [ :node |
			node isViennaApplyNode and: [
				(node expression isViennaLocalNameNode: shortName) or: [
					node expression
						isViennaGlobalNameNode: moduleName
						identifier: shortName ] ] ]
		do: [ :node | node argumentExpressionList add: ast copyFragment ]
]

{ #category : 'accessing' }
ViennaExtractParameterFromExpressionInFunction >> name [

	^ 'Extract parameter '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
	  , ' in function ' asText
	  , self definitionNode identifier asText allBold
]

{ #category : 'accessing' }
ViennaExtractParameterFromExpressionInFunction >> sortingOrder [
	^ 2.183
]
