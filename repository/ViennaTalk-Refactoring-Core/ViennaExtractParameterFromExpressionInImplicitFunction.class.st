Class {
	#name : #ViennaExtractParameterFromExpressionInImplicitFunction,
	#superclass : #ViennaExtractParameterFromExpressionInFunction,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractParameterFromExpressionInImplicitFunction >> executeDefinition [
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
ViennaExtractParameterFromExpressionInImplicitFunction >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ImplicitFunctionDefinition'
		ifAbsent: []
]