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
			binds := Dictionary new.
			self definitionNode parametersList allDescendantsDo: [ :patternNode |
				patternNode isViennaPatternIdentifierNode ifTrue: [
					binds at: patternNode name put: nil ] ].
			(self
				 match: self definitionNode expression
				 with: node
				 bindings: binds) ifTrue: [
				| args |
				args := self definitionNode parameters first asArray collect: [ :n |
					        self expressionFromPattern: n bindings: binds ].
				^ self replaceNode: node with: (ViennaApplyNode
						   expression: (ViennaLocalNameNode identifier: self identifier)
						   argumentExpressionList:
						   (ViennaExpressionListNode withAll: args)) ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrences >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast isViennaExplicitFunctionDefinitionNode ifTrue: [ ^ ast ].
	ast isViennaExpressionNode ifFalse: [ ^ nil ].
	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first isViennaFunctionDefinitionsNode ifTrue: [
				definitionBlock first do: [ :accessFunctionDefinition |
					accessFunctionDefinition second ifNotNil: [ :functionDefinition |
						functionDefinition first ifNotNil: [ :explicitFunctionDefinition |
							(explicitFunctionDefinition
								 isViennaExplicitFunctionDefinitionNode and: [
								 explicitFunctionDefinition pre isNil and: [
									 explicitFunctionDefinition expression isViennaLocalNameNode
										 not and: [
										 | binds |
										 binds := Dictionary new.
										 explicitFunctionDefinition parametersList
											 allDescendantsDo: [ :patternNode |
												 patternNode isViennaPatternIdentifierNode ifTrue: [
													 binds at: patternNode name put: nil ] ].
										 self
											 match: explicitFunctionDefinition expression
											 with: ast
											 bindings: binds ] ] ]) ifTrue: [
								^ explicitFunctionDefinition ] ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrences >> identifier [
	^ self definitionNode ifNotNil: #name
]
