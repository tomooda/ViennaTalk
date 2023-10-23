Class {
	#name : #ViennaInlineApplyFunctionAndRemove,
	#superclass : #ViennaInline,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #enumerating }
ViennaInlineApplyFunctionAndRemove >> callerNodesDo: aBlock [

	ast ifNil: [ ^ nil ].
	ast document
		allDescendantsSuchThat: [ :callerNode |
			callerNode isViennaApplyNode and: [
				callerNode expression resolve = self definitionNode ] ]
		do: aBlock
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> check [

	| identifier moduleName |
	ast ifNil: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	identifier := definitionNode identifier.
	moduleName := self definitionNode module identifier.
	(self definitionNode module moduleBody hasFreeIdentifier:
		 'pre_' , identifier) ifTrue: [ ^ false ].
	(self definitionNode module moduleBody hasFreeIdentifier:
		 'post_' , identifier) ifTrue: [ ^ false ].
	(ast document
		 hasGlobalReferenceToModule: moduleName
		 identifier: identifier) ifTrue: [ ^ false ].
	ast modulesDo: [ :module |
		(module importsFrom: moduleName identifier: identifier) ifTrue: [
			^ false ] ].
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
	functionName := self definitionNode identifier.
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
							   ViennaValueDefinitionNode
								   pattern: param
								   type: type
								   expression: arg ]))
				 expression: self definitionNode expression) ].
	(self definitionNode
		 detectParent: #isViennaFunctionDefinitionsNode
		 ifNone: [ nil ]) ifNotNil: [ :functionDefinitions |
		functionDefinitions remove: self definitionNode.
		functionDefinitions removeIfEmpty ].
	^ nil
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> findDefinitionNode [

	| identifier |
	ast ifNil: [ ^ nil ].
	(ast respondsTo: #identifier) ifFalse: [ ^ nil ].
	identifier := ast identifier.
	identifier ifNil: [ ^ nil ].
	(ast resolveIdentifier: identifier) ifNotNil: [ :defNode |
		defNode isViennaAccessFunctionDefinitionNode ifTrue: [ ^ defNode ] ].
	^ nil
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> name [

	^ (self
		   hasFreeOccurrencesOf: self definitionNode identifier
		   in: self definitionNode module)
		  ifTrue: [
			  'Inline '
			  ,
			  (self shortDescription: self definitionNode identifier) asText
				  allBold , ' and Remove' ]
		  ifFalse: [
		  'Remove ' asText , self definitionNode identifier asText allBold ]
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> sortingOrder [
	^ 2.15
]
