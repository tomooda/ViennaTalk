Class {
	#name : 'ViennaInlineApplyFunction',
	#superclass : 'ViennaInline',
	#instVars : [
		'callerNode',
		'definitionNode'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaInlineApplyFunction >> callerNode [
	^ callerNode ifNil: [ callerNode := self findCallerNode ]
]

{ #category : 'accessing' }
ViennaInlineApplyFunction >> callerNode: aViennaNode [
	callerNode := aViennaNode
]

{ #category : 'operations' }
ViennaInlineApplyFunction >> check [
	ast ifNil: [ ^ false ].
	self callerNode ifNil: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : 'accessing' }
ViennaInlineApplyFunction >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : 'accessing' }
ViennaInlineApplyFunction >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : 'operations' }
ViennaInlineApplyFunction >> execute [

	self definitionNode ifNil: [ ^ nil ].
	^ self replaceNode: self callerNode with: (ViennaLetExpressionNode
			   localDefinitionList: (ViennaLocalDefinitionListNode withAll:
					    ((1 to: self callerNode argumentExpressionList size)
						     collect: [ :index |
							     | param type arg |
							     param := (self definitionNode parametersList first at:
								               index) copyFragment.
							     type := self callerNode argumentExpressionList size = 1
								             ifTrue: [ self definitionNode type argumentType ]
								             ifFalse: [
									             self definitionNode type argumentType
										             isViennaProductTypeNode
										             ifTrue: [
										             self definitionNode type argumentType at: index ]
										             ifFalse: [ nil ] ].
							     arg := (self callerNode argumentExpressionList at: index)
								            copyFragment.
							     ViennaValueDefinitionNode
								     pattern: param
								     type: type
								     expression: arg ]))
			   expression: self definitionNode expression)
]

{ #category : 'accessing' }
ViennaInlineApplyFunction >> findCallerNode [

	| node |
	node := ast.
	node ifNil: [ ^ nil ].
	node isViennaLocalNameNode ifTrue: [ node := node parent ].
	node isViennaGlobalNameNode ifTrue: [ node := node parent ].
	node isViennaFunctionTypeInstantiationNode ifTrue: [
		node := node parent ].
	node isViennaApplyNode ifTrue: [ ^ node ].
	^ nil
]

{ #category : 'accessing' }
ViennaInlineApplyFunction >> findDefinitionNode [

	self callerNode ifNil: [ ^ nil ].
	self callerNode expression ifNotNil: [ :nameNode |
		nameNode isViennaLocalNameNode ifTrue: [
			^ (nameNode resolveIdentifier: nameNode first) ifNotNil: [ :defNode |
				  defNode isViennaAccessFunctionDefinitionNode
					  ifTrue: [ defNode ]
					  ifFalse: [ nil ] ] ].
		nameNode isViennaGlobalNameNode ifTrue: [
			^ (nameNode moduleNamed: nameNode first) ifNotNil: [ :moduleNode |
				  (moduleNode resolveIdentifier: nameNode second) ifNotNil: [
					  :defNode |
					  defNode isViennaAccessFunctionDefinitionNode
						  ifTrue: [ defNode ]
						  ifFalse: [ nil ] ] ] ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaInlineApplyFunction >> name [
	^ 'Inline '
		, (self shortDescription: self definitionNode identifier) asText allBold
]

{ #category : 'accessing' }
ViennaInlineApplyFunction >> sortingOrder [
	^ 2.14
]
