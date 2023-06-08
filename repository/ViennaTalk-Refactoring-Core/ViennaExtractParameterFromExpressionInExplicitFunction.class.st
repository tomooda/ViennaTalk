Class {
	#name : #ViennaExtractParameterFromExpressionInExplicitFunction,
	#superclass : #ViennaExtractParameterFromExpressionInFunction,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractParameterFromExpressionInExplicitFunction >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode third first in: [ :typeNode |
		typeNode isViennaProductTypeNode
			ifTrue: [ typeNode add: ViennaBasicTypeNode any ]
			ifFalse: [
				(self replaceNode: typeNode with: ViennaProductTypeNode empty)
					add: typeNode;
					add: ViennaBasicTypeNode any ] ].
	self definitionNode fifth first add:
		(ViennaPatternIdentifierNode identifier: self newName).
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInExplicitFunction >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'ExplicitFunctionDefinition'
		ifAbsent: []
]
