Class {
	#name : #ViennaUseFunction,
	#superclass : #ViennaUse,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseFunction >> execute [
	| binds args |
	binds := Dictionary new.
	self definitionNode fifth
		allDescendantsDo: [ :patternNode | 
			patternNode label = 'PatternIdentifier'
				ifTrue: [ binds at: patternNode name put: nil ] ].
	(self match: self definitionNode sixth with: ast bindings: binds)
		ifFalse: [ ^ nil ].
	args := self definitionNode fifth first asArray
		collect: [ :node | self expressionFromPattern: node bindings: binds ].
	^ self
		replaceNode: ast
		with:
			(ViennaNode
				label: 'Apply'
				with: (ViennaNode label: 'LocalName' with: self identifier)
				with: (ViennaNode label: 'ExpressionList' withAll: args))
]

{ #category : #accessing }
ViennaUseFunction >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	ast isExpressionNode ifFalse: [ ^nil ].
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'FunctionDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessFunctionDefinition | 
									accessFunctionDefinition second
										ifNotNil: [ :functionDefinition | 
											functionDefinition first
												ifNotNil: [ :explicitFunctionDefinition | 
													(explicitFunctionDefinition label = 'ExplicitFunctionDefinition'
														and: [ | binds |
															binds := Dictionary new.
															explicitFunctionDefinition fifth
																allDescendantsDo: [ :patternNode | 
																	patternNode label = 'PatternIdentifier'
																		ifTrue: [ binds at: patternNode name put: nil ] ].
															self
																match: explicitFunctionDefinition sixth
																with: ast
																bindings: binds ])
														ifTrue: [ ^ explicitFunctionDefinition ] ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseFunction >> identifier [
	^ self definitionNode name
]
