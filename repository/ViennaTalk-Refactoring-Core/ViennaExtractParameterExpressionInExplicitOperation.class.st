Class {
	#name : #ViennaExtractParameterExpressionInExplicitOperation,
	#superclass : #ViennaExtractParameterFromExpressionInOperation,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractParameterExpressionInExplicitOperation >> executeDefinition [
	self newName ifNil: [ ^ nil ].
	self definitionNode second first
		in: [ :typeNode | 
			typeNode label = 'UnitType'
				ifTrue: [ self
						replaceNode: typeNode
						with: (ViennaNode label: 'BasicType' with: 'any') ]
				ifFalse: [ typeNode label = 'ProductType'
						ifTrue: [ typeNode add: (ViennaNode label: 'BasicType' with: 'any') ]
						ifFalse: [ (self replaceNode: typeNode with: (ViennaNode label: 'ProductType'))
								add: typeNode;
								add: (ViennaNode label: 'BasicType' with: 'any') ] ] ].
	self definitionNode fourth
		add: (ViennaNode label: 'PatternIdentifier' with: self newName).
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractParameterExpressionInExplicitOperation >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ExplicitOperationDefinition'
		ifAbsent: []
]
