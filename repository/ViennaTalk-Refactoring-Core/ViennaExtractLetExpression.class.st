Class {
	#name : #ViennaExtractLetExpression,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractLetExpression >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	ast label = 'LetExpression'
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractLetExpression >> execute [
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
ViennaExtractLetExpression >> findNewName [
	(UIManager default
		request: 'local name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractLetExpression >> name [
	^ 'Extract let expression with ' asText , ast source asText allBold
]

{ #category : #accessing }
ViennaExtractLetExpression >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaExtractLetExpression >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaExtractLetExpression >> sortingOrder [
	^ 2.52
]
