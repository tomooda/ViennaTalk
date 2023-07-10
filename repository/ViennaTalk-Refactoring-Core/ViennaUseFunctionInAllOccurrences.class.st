Class {
	#name : #ViennaUseFunctionInAllOccurrences,
	#superclass : #ViennaUseInAllOccurrences,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseFunctionInAllOccurrences >> execute [
	[ self executeOne notNil ] whileTrue.
	^ nil
]

{ #category : #operations }
ViennaUseFunctionInAllOccurrences >> executeOne [

	self definitionNode module allDescendantsDo: [ :node |
		(node includesParent: self definitionNode) not ifTrue: [
			| binds |
			binds := (self definitionNode parametersList uniqueBoundIdentifiers
				          collect: [ :identifier | identifier -> nil ])
				         asDictionary.
			(self
				 match: self definitionNode expression
				 with: node
				 bindings: binds) ifTrue: [
				| args |
				args := self definitionNode parametersList first asArray collect: [
					        :n | self expressionFromPattern: n bindings: binds ].
				^ self replaceNode: node with: (ViennaApplyNode
						   expression: (ViennaLocalNameNode identifier: self identifier)
						   argumentExpressionList:
						   (ViennaExpressionListNode withAll: args)) ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrences >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	^ ast localResolve ifNotNil: [ :def |
		  | accessDef |
		  accessDef := def asAccessDefinition.
		  (accessDef isViennaAccessFunctionDefinitionNode and: [
			   accessDef pre isNil ]) ifTrue: [ accessDef ] ]
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrences >> identifier [

	^ self definitionNode ifNotNil: #identifier
]
