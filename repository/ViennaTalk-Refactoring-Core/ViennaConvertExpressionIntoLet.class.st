Class {
	#name : #ViennaConvertExpressionIntoLet,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaConvertExpressionIntoLet >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	ast label = 'LetExpression'
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaConvertExpressionIntoLet >> execute [
	self
		replaceNode: ast
		with:
			(ViennaNode
				label: 'LetExpression'
				with:
					(ViennaNode
						label: 'LocalDefinitionList'
						with:
							(ViennaNode
								label: 'LocalDefinition'
								with:
									(ViennaNode
										label: 'ValueDefinition'
										with: (ViennaNode label: 'PatternIdentifier' with: self newName)
										with: nil
										with: ast copyFragment)))
				with: (ViennaNode label: 'LocalName' with: self newName))
]

{ #category : #accessing }
ViennaConvertExpressionIntoLet >> findNewName [
	(UIManager default
		request: 'local name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaConvertExpressionIntoLet >> name [
	^ 'convert ' asText , ast source asText allBold
		, ' into a let expression' asText
]

{ #category : #accessing }
ViennaConvertExpressionIntoLet >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaConvertExpressionIntoLet >> newName: aString [
	newName := aString
]
