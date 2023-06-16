Class {
	#name : #ViennaInlineApplyFunctionAndRemove,
	#superclass : #ViennaInline,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> check [

	| shortName moduleName |
	ast ifNil: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	shortName := definitionNode first.
	moduleName := self definitionNode module name.
	self freeOccurrencesOf: shortName in: ast module do: [ :node |
		(node parent isViennaApplyNode and: [
			 node parent expression == node ]) ifFalse: [ ^ false ] ].
	(self hasFreeOccurrencesOf: 'pre_' , shortName in: ast module)
		ifTrue: [ ^ false ].
	(self hasFreeOccurrencesOf: 'post_' , shortName in: ast module)
		ifTrue: [ ^ false ].
	ast document allDescendantsDo: [ :node |
		(node isViennaGlobalNameNode and: [
			 node moduleIdentifier = moduleName and: [
				 node identifier = shortName ] ]) ifTrue: [ ^ false ] ].
	ast modulesDo: [ :module |
		module second first ifNotNil: [ :importDefinitionList |
			importDefinitionList do: [ :importDefinition |
				importDefinition first = moduleName ifTrue: [
					importDefinition allDescendantsDo: [ :node |
						(node isViennaFunctionImportNode: shortName) ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaInlineApplyFunctionAndRemove >> execute [

	| functionName |
	functionName := self definitionNode name.
	self freeOccurrencesOf: functionName in: ast module do: [ :node |
		| callerNode |
		callerNode := node parent.
		self replaceNode: callerNode with: (ViennaLetExpressionNode
				 localDefinitionList: (ViennaLocalDefinitionListNode withAll:
						  ((1 to: callerNode argumentExpressionList size) collect: [
							   :index |
							   | param type arg |
							   param := (self definitionNode parametersList first at: index)
								            copyFragment.
							   type := callerNode argumentExpressionList size = 1
								           ifTrue: [ self definitionNode type argumentType ]
								           ifFalse: [
									           self definitionNode type argumentType
										           isViennaProductTypeNode
										           ifTrue: [
										           self definitionNode type argumentType at: index ]
										           ifFalse: [ nil ] ].
							   arg := (callerNode argumentExpressionList at: index)
								          copyFragment.
							   ViennaLocalDefinitionNode
								   valueDefinitionOrFunctionDefinition:
								   (ViennaValueDefinitionNode
									    pattern: param
									    type: type
									    expression: arg) ]))
				 expression: self definitionNode expression) ].
	(ast detectParent: #isViennaFunctionDefinitionsNode ifNone: [ nil ])
		ifNotNil: [ :functionDefinitions |
			functionDefinitions remove: self definitionNode parent parent.
			functionDefinitions ifEmpty: [
				functionDefinitions parent parent remove:
					functionDefinitions parent ] ].
	^ nil
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> findDefinitionNode [

	| identifier |
	identifier := ast identifier.
	identifier ifNil: [ ^ nil ].
	(ast resolveLocalName: identifier) ifNotNil: [ :defNode |
		defNode isViennaExplicitFunctionDefinitionNode ifTrue: [ ^ defNode ].
		defNode isViennaImplicitFunctionDefinitionNode ifTrue: [ ^ defNode ] ].
	^ nil
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> name [
	^ (self
		hasFreeOccurrencesOf: self definitionNode name
		in: self definitionNode module)
		ifTrue: [ 'Inline '
				, (self shortDescription: self definitionNode name) asText allBold
				, ' and Remove' ]
		ifFalse: [ 'Remove ' asText , self definitionNode name asText allBold ]
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> sortingOrder [
	^ 2.15
]
