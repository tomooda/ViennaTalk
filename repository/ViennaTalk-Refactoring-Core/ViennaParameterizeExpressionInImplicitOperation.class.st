Class {
	#name : #ViennaParameterizeExpressionInImplicitOperation,
	#superclass : #ViennaParameterizeExpressionInOperation,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaParameterizeExpressionInImplicitOperation >> executeDefinition [
	self newName ifNil: [ ^ nil ].
	self definitionNode second first
		add:
			(ViennaNode
				label: 'PatternList'
				with: (ViennaNode label: 'PatternIdentifier' with: self newName));
		add: (ViennaNode label: 'BasicType' with: 'any').
	^ self definitionNode
]

{ #category : #accessing }
ViennaParameterizeExpressionInImplicitOperation >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ImplicitOperationDefinition'
		ifAbsent: []
]
