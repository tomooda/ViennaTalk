Class {
	#name : #ViennaWidenLetExpression,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaWidenLetExpression >> check [
	ast ifNil: [ ^ false ].
	ast label = 'LetExpression'
		ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaWidenLetExpression >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaWidenLetExpression >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaWidenLetExpression >> execute [
	| dummy base parent |
	dummy := ViennaNode label: 'DUMMY'.
	base := self definitionNode.
	parent := ast parent.
	self replaceNode: base with: dummy.
	self replaceNode: ast with: ast second.
	ast at: 2 put: base.
	self replaceNode: dummy with: ast
]

{ #category : #accessing }
ViennaWidenLetExpression >> findDefinitionNode [
	| node |
	node := ast parent.
	[ node ifNil: [ ^ false ].
	node isExpressionNode ] whileFalse: [ node := node parent ].
	^ node
]

{ #category : #accessing }
ViennaWidenLetExpression >> name [
	^ 'widen ' , ast source asText allBold
]
