Class {
	#name : 'ViennaExtractParameterExpressionInExplicitOperation',
	#superclass : 'ViennaExtractParameterFromExpressionInOperation',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaExtractParameterExpressionInExplicitOperation >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode argumentType in: [ :typeNode |
		typeNode isViennaUnitTypeNode
			ifTrue: [ self replaceNode: typeNode with: ViennaBasicTypeNode any ]
			ifFalse: [
				typeNode isViennaProductTypeNode
					ifTrue: [ typeNode add: ViennaBasicTypeNode any ]
					ifFalse: [
						(self replaceNode: typeNode with: ViennaProductTypeNode empty)
							add: typeNode;
							add: ViennaBasicTypeNode any ] ] ].
	self definitionNode parameters add:
		(ViennaPatternIdentifierNode identifier: self newName).
	^ self definitionNode
]

{ #category : 'accessing' }
ViennaExtractParameterExpressionInExplicitOperation >> findDefinitionNode [

	^ ast
		  detectParent: #isViennaExplicitOperationDefinitionNode
		  ifNone: [  ]
]
