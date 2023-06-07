Class {
	#name : #ViennaExtractParameterFromExpressionInImplicitOperation,
	#superclass : #ViennaExtractParameterFromExpressionInOperation,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractParameterFromExpressionInImplicitOperation >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode second first
		add: (ViennaNode
				 label: 'PatternList'
				 with: (ViennaPatternIdentifierNode identifier: self newName));
		add: ViennaBasicTypeNode any.
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitOperation >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ImplicitOperationDefinition'
		ifAbsent: []
]
