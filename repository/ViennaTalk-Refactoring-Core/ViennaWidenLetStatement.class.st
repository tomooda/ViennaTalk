Class {
	#name : #ViennaWidenLetStatement,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaWidenLetStatement >> check [
	ast ifNil: [ ^ false ].
	ast label = 'LetStatement'
		ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaWidenLetStatement >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaWidenLetStatement >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaWidenLetStatement >> execute [
	| dummy base |
	dummy := ViennaNode label: 'DUMMY'.
	base := self definitionNode.
	self replaceNode: base with: dummy.
	self replaceNode: ast with: ast second.
	ast at: 2 put: base.
	^ self replaceNode: dummy with: ast
]

{ #category : #accessing }
ViennaWidenLetStatement >> findDefinitionNode [
	| node |
	node := ast parent.
	[ node ifNil: [ ^ nil ].
	node isStatementNode ] whileFalse: [ node := node parent ].
	^ node
]

{ #category : #accessing }
ViennaWidenLetStatement >> name [
	^ 'widen ' , ast source asText allBold
]
