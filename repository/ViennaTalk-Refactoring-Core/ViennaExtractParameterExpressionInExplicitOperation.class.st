Class {
	#name : #ViennaExtractParameterExpressionInExplicitOperation,
	#superclass : #ViennaExtractParameterFromExpressionInOperation,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractParameterExpressionInExplicitOperation >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode second first in: [ :typeNode |
		typeNode isViennaUnitTypeNode
			ifTrue: [ self replaceNode: typeNode with: ViennaBasicTypeNode any ]
			ifFalse: [
				typeNode isViennaProductTypeNode
					ifTrue: [ typeNode add: ViennaBasicTypeNode any ]
					ifFalse: [
						(self replaceNode: typeNode with: ViennaProductTypeNode empty)
							add: typeNode;
							add: ViennaBasicTypeNode any ] ] ].
	self definitionNode fourth add:
		(ViennaPatternIdentifierNode identifier: self newName).
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractParameterExpressionInExplicitOperation >> findDefinitionNode [

	^ ast parent
		  detectParent: #isViennaExplicitOperationDefinitionNode
		  ifNone: [  ]
]
