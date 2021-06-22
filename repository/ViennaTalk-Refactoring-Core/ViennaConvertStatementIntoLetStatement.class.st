Class {
	#name : #ViennaConvertStatementIntoLetStatement,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName',
		'statementNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaConvertStatementIntoLetStatement >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	self statementNode ifNil: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaConvertStatementIntoLetStatement >> execute [
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
ViennaConvertStatementIntoLetStatement >> findNewName [
	(UIManager default
		request: 'local name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaConvertStatementIntoLetStatement >> findStatementNode [
	| node |
	node := ast parent.
	[ node ifNil: [ ^ nil ].
	node isStatementNode ] whileFalse: [ node := node parent ].
	^ node
]

{ #category : #accessing }
ViennaConvertStatementIntoLetStatement >> name [
	^ 'convert ' asText , ast source asText allBold
		, ' into a let statement' asText
]

{ #category : #accessing }
ViennaConvertStatementIntoLetStatement >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaConvertStatementIntoLetStatement >> newName: anObject [
	newName := anObject
]

{ #category : #accessing }
ViennaConvertStatementIntoLetStatement >> sortingOrder [
	^ 2.58
]

{ #category : #accessing }
ViennaConvertStatementIntoLetStatement >> statementNode [
	^ statementNode ifNil: [ statementNode := self findStatementNode ]
]

{ #category : #accessing }
ViennaConvertStatementIntoLetStatement >> statementNode: anObject [
	statementNode := anObject
]
