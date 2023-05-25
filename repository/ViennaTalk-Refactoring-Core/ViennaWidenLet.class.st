Class {
	#name : #ViennaWidenLet,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaWidenLet class >> isAbstract [
	^ self = ViennaWidenLet
]

{ #category : #testing }
ViennaWidenLet >> acceptsDefinitionNode: aViennaNode [
	^ self subclassResponsibility
]

{ #category : #testing }
ViennaWidenLet >> acceptsNode: aViennaNode [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaWidenLet >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaWidenLet >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaWidenLet >> execute [
	| dummy base |
	dummy := ViennaNode label: 'DUMMY'.
	base := self definitionNode.
	self replaceNode: base with: dummy.
	self replaceNode: ast with: ast second.
	ast at: 2 put: base.
	^ self replaceNode: dummy with: ast
]

{ #category : #accessing }
ViennaWidenLet >> findDefinitionNode [
	| node |
	node := ast parent.
	[ node ifNil: [ ^ nil ].
	self acceptsDefinitionNode: node ]
		whileFalse: [ node := node parent ].
	^ node
]

{ #category : #accessing }
ViennaWidenLet >> name [
	^ 'Widen ' , (self shortDescription: ast source) asText allBold
]
