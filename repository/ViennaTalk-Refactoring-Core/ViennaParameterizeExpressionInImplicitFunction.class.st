Class {
	#name : #ViennaParameterizeExpressionInImplicitFunction,
	#superclass : #ViennaParameterizeExpressionInFunction,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaParameterizeExpressionInImplicitFunction >> executeDefinition [
	self newName ifNil: [ ^ nil ].
	self definitionNode third first
		add:
			(ViennaNode
				label: 'PatternList'
				with: (ViennaNode label: 'PatternIdentifier' with: self newName));
		add: (ViennaNode label: 'BasicType' with: 'any').
	^ self definitionNode
]

{ #category : #accessing }
ViennaParameterizeExpressionInImplicitFunction >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ImplicitFunctionDefinition'
		ifAbsent: []
]
