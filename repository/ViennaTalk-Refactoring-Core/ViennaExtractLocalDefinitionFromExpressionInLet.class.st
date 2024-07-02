Class {
	#name : 'ViennaExtractLocalDefinitionFromExpressionInLet',
	#superclass : 'ViennaExtractParameter',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaExtractLocalDefinitionFromExpressionInLet >> check [

	ast ifNil: [ ^ false ].
	ast isViennaExpressionNode ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	ast uniqueFreeIdentifiersDo: [ :identifier |
		(self definitionNode localDefinitionList bindsIdentifier: identifier)
			ifTrue: [ ^ false ] ].
	^ true
]

{ #category : 'operations' }
ViennaExtractLocalDefinitionFromExpressionInLet >> executeCallers [
	
]

{ #category : 'operations' }
ViennaExtractLocalDefinitionFromExpressionInLet >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode first add: (ViennaValueDefinitionNode
			 pattern: (ViennaPatternIdentifierNode identifier: self newName)
			 type: nil
			 expression: ast).
	^ self definitionNode
]

{ #category : 'accessing' }
ViennaExtractLocalDefinitionFromExpressionInLet >> findDefinitionNode [

	^ ast detectParent: #isViennaLetNode ifNone: [ nil ]
]

{ #category : 'accessing' }
ViennaExtractLocalDefinitionFromExpressionInLet >> name [

	^ 'Extract local definition ' asText
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' = ' ])
	  , (self shortDescription: ast source) asText allBold
	  , ' in a LET expression' asText
]

{ #category : 'accessing' }
ViennaExtractLocalDefinitionFromExpressionInLet >> sortingOrder [
	^ 2.187
]
