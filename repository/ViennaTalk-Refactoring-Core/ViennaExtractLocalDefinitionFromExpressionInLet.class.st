Class {
	#name : #ViennaExtractLocalDefinitionFromExpressionInLet,
	#superclass : #ViennaExtractParameter,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractLocalDefinitionFromExpressionInLet >> check [

	ast ifNil: [ ^ false ].
	ast isViennaExpressionNode ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	(ast isViennaLocalNameNode and: [
		 (ast resolveIdentifier: ast identifier) includesParent:
			 self definitionNode ]) ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractLocalDefinitionFromExpressionInLet >> executeCallers [
	
]

{ #category : #operations }
ViennaExtractLocalDefinitionFromExpressionInLet >> executeDefinition [

	self newName ifNil: [ ^ nil ].
	self definitionNode first add:
		(ViennaLocalDefinitionNode valueDefinitionOrFunctionDefinition:
			 (ViennaValueDefinitionNode
				  pattern: (ViennaPatternIdentifierNode identifier: self newName)
				  type: nil
				  expression: ast)).
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLet >> findDefinitionNode [

	^ ast detectParent: #isViennaLetNode ifNone: [ nil ]
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLet >> name [

	^ 'Extract local definition ' asText
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' = ' ])
	  , (self shortDescription: ast source) asText allBold
	  , ' in a LET expression' asText
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLet >> sortingOrder [
	^ 2.187
]
