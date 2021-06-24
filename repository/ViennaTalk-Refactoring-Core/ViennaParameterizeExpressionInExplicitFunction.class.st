Class {
	#name : #ViennaParameterizeExpressionInExplicitFunction,
	#superclass : #ViennaParameterizeExpressionInFunction,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaParameterizeExpressionInExplicitFunction >> executeDefinition [
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
ViennaParameterizeExpressionInExplicitFunction >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ExplicitFunctionDefinition'
		ifAbsent: []
]
