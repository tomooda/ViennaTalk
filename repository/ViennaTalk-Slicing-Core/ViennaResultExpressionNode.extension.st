Extension { #name : 'ViennaResultExpressionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaResultExpressionNode >> sliceWith: aViennaSlicer [

	(self
		 detectParent: #isViennaExplicitFunctionDefinitionNode
		 ifNone: [ nil ]) ifNotNil: [ :functionDefinition |
		| apply |
		aViennaSlicer onNode: self do: [
			apply := ViennaLocalNameNode identifier:
				         functionDefinition identifier.
			functionDefinition parametersList do: [ :patternList |
				apply := ViennaApplyNode
					         expression: apply
					         argumentExpressionList: patternList asExpression ].
			apply parent: self.
			aViennaSlicer write: self.
			aViennaSlicer read: apply.
			^ apply sliceWith: aViennaSlicer ] ].
	(self
		 detectParent: #isViennaExplicitOperationDefinitionNode
		 ifNone: [ nil ]) ifNotNil: [ :operationDefinition |
		| apply |
		aViennaSlicer onNode: self do: [
			apply := ViennaApplyNode
				         expression:
				         (ViennaLocalNameNode identifier:
					          operationDefinition identifier)
				         argumentExpressionList:
				         operationDefinition parameters asExpression.
			apply parent: self.
			aViennaSlicer write: self.
			aViennaSlicer read: apply.
			^ apply sliceWith: aViennaSlicer ] ].
	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
