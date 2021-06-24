Class {
	#name : #ViennaNarrowLet,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaNarrowLet class >> isAbstract [
	^ self = ViennaNarrowLet
]

{ #category : #testing }
ViennaNarrowLet >> acceptsAstLabel: aString [
	^ self subclassResponsibility
]

{ #category : #operations }
ViennaNarrowLet >> check [
	ast ifNil: [ ^ false ].
	(self acceptsAstLabel: ast label)
		ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaNarrowLet >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaNarrowLet >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaNarrowLet >> execute [
	| dummy base |
	dummy := self replaceNode: ast with: (ViennaNode label: 'DUMMY').
	base := ast second.
	self replaceNode: self definitionNode with: ast.
	ast at: 2 put: self definitionNode.
	^ self replaceNode: dummy with: base
]

{ #category : #accessing }
ViennaNarrowLet >> findDefinitionNode [
	| paramNames |
	paramNames := Set new: ast first size * 2.
	ast first
		do: [ :localDefinition | 
			localDefinition first label = 'ValueDefinition'
				ifTrue: [ localDefinition first first
						allDescendantsDo: [ :node | 
							node label = 'PatternIdentifier'
								ifTrue: [ paramNames add: node first ] ] ]
				ifFalse: [ ^ nil ] ].
	paramNames := paramNames asArray.
	^ (ast second asArray
		select: [ :node | 
			node isViennaNode
				and: [ paramNames
						anySatisfy: [ :param | self hasFreeOccurrencesOf: param in: node ] ] ])
		ifNotEmpty: [ :nodes | 
			nodes size = 1
				ifTrue: [ nodes first ]
				ifFalse: [ nil ] ]
		ifEmpty: [ nil ]
]

{ #category : #accessing }
ViennaNarrowLet >> name [
	^ 'Narrow ' , ast source asText allBold
]
