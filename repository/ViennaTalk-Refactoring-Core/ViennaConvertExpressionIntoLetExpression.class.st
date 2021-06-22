Class {
	#name : #ViennaConvertExpressionIntoLetExpression,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaConvertExpressionIntoLetExpression >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	ast label = 'LetExpression'
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaConvertExpressionIntoLetExpression >> execute [
	self newName ifNil: [ ^ nil ].
	^ self
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
ViennaConvertExpressionIntoLetExpression >> findNewName [
	(UIManager default
		request: 'local name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaConvertExpressionIntoLetExpression >> name [
	^ 'convert ' asText , ast source asText allBold
		, ' into a let expression' asText
]

{ #category : #accessing }
ViennaConvertExpressionIntoLetExpression >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaConvertExpressionIntoLetExpression >> newName: aString [
	newName := aString
]
