Class {
	#name : #ViennaExtractParameterFromExpressionInImplicitOperation,
	#superclass : #ViennaExtractParameterFromExpressionInOperation,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractParameterFromExpressionInImplicitOperation >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode parameterTypes patternTypePairList
		add: (ViennaPatternListNode withAll:
					 { (ViennaPatternIdentifierNode identifier: self newName) });
		add: ViennaBasicTypeNode any.
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitOperation >> findDefinitionNode [

	^ ast parent
		  detectParent: #isViennaImplicitOperationDefinitionNode
		  ifNone: [  ]
]
