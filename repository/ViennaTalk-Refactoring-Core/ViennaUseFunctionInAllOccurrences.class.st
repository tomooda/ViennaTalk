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
			self definitionNode fifth allDescendantsDo: [ :patternNode |
				patternNode isViennaPatternIdentifierNode ifTrue: [
					binds at: patternNode name put: nil ] ].
			(self match: self definitionNode sixth with: node bindings: binds)
				ifTrue: [
					| args |
					args := self definitionNode fifth first asArray collect: [ :n |
						        self expressionFromPattern: n bindings: binds ].
					^ self replaceNode: node with: (ViennaApplyNode
							   expression:
							   (ViennaLocalNameNode identifier: self identifier)
							   argumentExpressionList:
							   (ViennaNode label: 'ExpressionList' withAll: args)) ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrences >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast label = 'ExplicitFunctionDefinition' ifTrue: [ ^ ast ].
	ast isViennaExpressionNode ifFalse: [ ^ nil ].
	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first label = 'FunctionDefinitions' ifTrue: [
				definitionBlock first do: [ :accessFunctionDefinition |
					accessFunctionDefinition second ifNotNil: [ :functionDefinition |
						functionDefinition first ifNotNil: [ :explicitFunctionDefinition |
							(explicitFunctionDefinition label
							 = 'ExplicitFunctionDefinition' and: [
								 explicitFunctionDefinition seventh isNil and: [
									 explicitFunctionDefinition sixth isViennaLocalNameNode not
										 and: [
											 | binds |
											 binds := Dictionary new.
											 explicitFunctionDefinition fifth allDescendantsDo: [
												 :patternNode |
												 patternNode isViennaPatternIdentifierNode ifTrue: [
													 binds at: patternNode name put: nil ] ].
											 self
												 match: explicitFunctionDefinition sixth
												 with: ast
												 bindings: binds ] ] ]) ifTrue: [
								^ explicitFunctionDefinition ] ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrences >> identifier [
	^ self definitionNode ifNotNil: #name
]
