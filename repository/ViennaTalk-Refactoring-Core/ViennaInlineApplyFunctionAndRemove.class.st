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
						(node label = 'FunctionImport' and: [ node first = shortName ])
							ifTrue: [ ^ false ] ] ] ] ] ].
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
				 localDefinitionList: (ViennaNode
						  label: 'LocalDefinitionList'
						  withAll: ((1 to: callerNode second size) collect: [ :index |
								   | param type arg |
								   param := (self definitionNode fifth first at: index)
									            copyFragment.
								   type := callerNode second size = 1
									           ifTrue: [ self definitionNode third first ]
									           ifFalse: [
										           self definitionNode third first
											           isViennaProductTypeNode
											           ifTrue: [
											           self definitionNode third first at: index ]
											           ifFalse: [ nil ] ].
								   arg := (callerNode second at: index) copyFragment.
								   ViennaNode label: 'LocalDefinition' with: (ViennaNode
										    label: 'ValueDefinition'
										    with: param
										    with: type
										    with: arg) ]))
				 expression: self definitionNode sixth) ].
	(ast parentLabelled: 'FunctionDefinitions' ifAbsent: [ nil ])
		ifNotNil: [ :functionDefinitions |
			functionDefinitions remove: self definitionNode parent parent.
			functionDefinitions ifEmpty: [
				functionDefinitions parent parent remove:
					functionDefinitions parent ] ].
	^ nil
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemove >> findDefinitionNode [
	| name |
	name := ast name.
	name ifNil: [ ^ nil ].
	(ast resolveLocalName: name)
		ifNotNil: [ :defNode | 
			(#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition')
				includes: defNode label)
				ifTrue: [ ^ defNode ] ].
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
