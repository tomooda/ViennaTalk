Class {
	#name : #ViennaUseFunction,
	#superclass : #ViennaUse,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseFunction >> execute [

	| binds args |
	binds := Dictionary new.
	self definitionNode parametersList allDescendantsDo: [ :patternNode |
		patternNode isViennaPatternIdentifierNode ifTrue: [
			binds at: patternNode name put: nil ] ].
	(self match: self definitionNode expression with: ast bindings: binds)
		ifFalse: [ ^ nil ].
	args := self definitionNode parametersList first asArray collect: [
		        :node | self expressionFromPattern: node bindings: binds ].
	^ self replaceNode: ast with: (ViennaApplyNode
			   expression: (ViennaLocalNameNode identifier: self identifier)
			   argumentExpressionList: (ViennaExpressionListNode withAll: args))
]

{ #category : #accessing }
ViennaUseFunction >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
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
ViennaUseFunction >> identifier [
	^ self definitionNode name
]
