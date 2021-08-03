Class {
	#name : #ViennaExtractLocalDefinitionFromExpressionInLet,
	#superclass : #ViennaExtractParameter,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractLocalDefinitionFromExpressionInLet >> check [
	ast ifNil: [ ^ false ].
	ast isExpressionNode
		ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	(ast label = 'LocalName'
		and: [ (ast definitionOfLocalName: ast first)
				includesParent: self definitionNode ])
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractLocalDefinitionFromExpressionInLet >> executeCallers [
	
]

{ #category : #operations }
ViennaExtractLocalDefinitionFromExpressionInLet >> executeDefinition [
	self newName ifNil: [ ^ nil ].
	self definitionNode first
		add:
			(ViennaNode
				label: 'LocalDefinition'
				with:
					(ViennaNode
						label: 'ValueDefinition'
						with: (ViennaNode label: 'PatternIdentifier' with: self newName)
						with: nil
						with: ast)).
	^ self definitionNode
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLet >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'LetExpression'
		ifAbsent: [ ast parent parentLabelled: 'LetStatement' ifAbsent: [ nil ] ]
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLet >> name [
	^ 'Extract local definition ' asText
		, (self shortDescription: ast source) asText allBold
		, ' in a LET expression' asText
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLet >> sortingOrder [
	^ 2.187
]
