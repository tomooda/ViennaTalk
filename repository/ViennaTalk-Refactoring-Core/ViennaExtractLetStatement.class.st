Class {
	#name : 'ViennaExtractLetStatement',
	#superclass : 'ViennaExtract',
	#instVars : [
		'statementNode'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaExtractLetStatement >> check [
	ast isViennaExpressionNode
		ifFalse: [ ^ false ].
	self statementNode ifNil: [ ^ false ].
	ast isOperationNameNode
		ifTrue: [ ^ false ].
	^ true
]

{ #category : 'operations' }
ViennaExtractLetStatement >> execute [

	| dummy |
	self newName ifNil: [ ^ nil ].
	dummy := self
		         replaceNode: self statementNode
		         with: ViennaDummyNode empty.
	self
		replaceNode: ast
		with: (ViennaLocalNameNode identifier: self newName).
	^ self replaceNode: dummy with: (ViennaLetStatementNode
			   localDefinitionList:
				   (ViennaLocalDefinitionListNode withAll:
					    { (ViennaValueDefinitionNode
						     pattern:
						     (ViennaPatternIdentifierNode identifier: self newName)
						     type: nil
						     expression: ast) })
			   statement: self statementNode)
]

{ #category : 'accessing' }
ViennaExtractLetStatement >> findNewName [
	(UIManager default
		request: 'local name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaExtractLetStatement >> findStatementNode [
	| node |
	node := ast parent.
	[ node ifNil: [ ^ nil ].
	node isViennaStatementNode ] whileFalse: [ node := node parent ].
	^ node
]

{ #category : 'accessing' }
ViennaExtractLetStatement >> name [

	^ 'Extract let statement with ' asText
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' = ' ])
	  , (self shortDescription: ast source) asText allBold
]

{ #category : 'accessing' }
ViennaExtractLetStatement >> sortingOrder [
	^ 2.58
]

{ #category : 'accessing' }
ViennaExtractLetStatement >> statementNode [
	^ statementNode ifNil: [ statementNode := self findStatementNode ]
]

{ #category : 'accessing' }
ViennaExtractLetStatement >> statementNode: anObject [
	statementNode := anObject
]
