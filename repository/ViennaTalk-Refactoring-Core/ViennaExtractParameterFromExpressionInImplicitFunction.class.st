Class {
	#name : 'ViennaExtractParameterFromExpressionInImplicitFunction',
	#superclass : 'ViennaExtractParameterFromExpressionInFunction',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaExtractParameterFromExpressionInImplicitFunction >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode patternTypePairList
		add: (ViennaPatternListNode withAll:
					 { (ViennaPatternIdentifierNode identifier: self newName) });
		add: ViennaBasicTypeNode any.
	^ self definitionNode
]

{ #category : 'accessing' }
ViennaExtractParameterFromExpressionInImplicitFunction >> findDefinitionNode [

	^ ast parent
		  detectParent: #isViennaImplicitFunctionDefinitionNode
		  ifNone: [  ]
]
