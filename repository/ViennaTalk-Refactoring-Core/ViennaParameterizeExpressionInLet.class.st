Class {
	#name : #ViennaParameterizeExpressionInLet,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName',
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaParameterizeExpressionInLet >> check [
	ast ifNil: [ ^ false ].
	ast isExpressionNode
		ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaParameterizeExpressionInLet >> execute [
	self newName ifNil: [ ^ nil ].
	self
		replaceNode: ast
		with: (ViennaNode label: 'LocalName' with: self newName).
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
ViennaParameterizeExpressionInLet >> findNewName [
	(UIManager default
		request: 'new parameter name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> name [
	^ 'parameterize ' asText , ast source asText allBold
		, ' in a let expression' asText
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaParameterizeExpressionInLet >> sortingOrder [
	^ 2.18
]
