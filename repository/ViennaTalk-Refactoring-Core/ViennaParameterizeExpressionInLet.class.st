Class {
	#name : #ViennaParameterizeExpressionInLet,
	#superclass : #ViennaParameterize,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaParameterizeExpressionInLet >> check [
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
ViennaParameterizeExpressionInLet >> executeCallers [
	
]

{ #category : #operations }
ViennaParameterizeExpressionInLet >> executeDefinition [
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
ViennaParameterizeExpressionInLet >> findDefinitionNode [
	^ ast parent
		parentLabelled: 'LetExpression'
		ifAbsent: [ ast parent parentLabelled: 'LetStatement' ifAbsent: [ nil ] ]
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> name [
	^ 'Parameterize ' asText , ast source asText allBold
		, ' in a LET expression' asText
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> sortingOrder [
	^ 2.187
]
