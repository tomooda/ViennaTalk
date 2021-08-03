Class {
	#name : #ViennaExtractParameterFromExpressionInExplicitFunction,
	#superclass : #ViennaExtractParameterFromExpressionInFunction,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractParameterFromExpressionInExplicitFunction >> executeDefinition [
	self newName ifNil: [ ^ nil ].
	self definitionNode third first
		in: [ :typeNode | 
			typeNode label = 'ProductType'
				ifTrue: [ typeNode add: (ViennaNode label: 'BasicType' with: 'any') ]
				ifFalse: [ (self replaceNode: typeNode with: (ViennaNode label: 'ProductType'))
						add: typeNode;
						add: (ViennaNode label: 'BasicType' with: 'any') ] ].
	self definitionNode fifth first
		add: (ViennaNode label: 'PatternIdentifier' with: self newName).
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInExplicitFunction >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ExplicitFunctionDefinition'
		ifAbsent: []
]
