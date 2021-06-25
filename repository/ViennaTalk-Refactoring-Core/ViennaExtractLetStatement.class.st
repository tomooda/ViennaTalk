Class {
	#name : #ViennaExtractLetStatement,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName',
		'statementNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractLetStatement >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	self statementNode ifNil: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractLetStatement >> execute [
	| dummy |
	self newName ifNil: [ ^ nil ].
	dummy := self
		replaceNode: self statementNode
		with: (ViennaNode label: 'DUMMY').
	self
		replaceNode: ast
		with: (ViennaNode label: 'LocalName' with: self newName).
	^ self
		replaceNode: dummy
		with:
			(ViennaNode
				label: 'LetStatement'
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
										with: ast)))
				with: self statementNode)
]

{ #category : #accessing }
ViennaExtractLetStatement >> findNewName [
	(UIManager default
		request: 'local name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractLetStatement >> findStatementNode [
	| node |
	node := ast parent.
	[ node ifNil: [ ^ nil ].
	node isStatementNode ] whileFalse: [ node := node parent ].
	^ node
]

{ #category : #accessing }
ViennaExtractLetStatement >> name [
	^ 'Extract let statement with ' asText
		, (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractLetStatement >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaExtractLetStatement >> newName: anObject [
	newName := anObject
]

{ #category : #accessing }
ViennaExtractLetStatement >> sortingOrder [
	^ 2.58
]

{ #category : #accessing }
ViennaExtractLetStatement >> statementNode [
	^ statementNode ifNil: [ statementNode := self findStatementNode ]
]

{ #category : #accessing }
ViennaExtractLetStatement >> statementNode: anObject [
	statementNode := anObject
]
