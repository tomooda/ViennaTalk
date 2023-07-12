Class {
	#name : #ViennaNarrowLetStatement,
	#superclass : #ViennaNarrowLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaNarrowLetStatement >> acceptsNode: aViennaNode [

	^ aViennaNode isViennaLetStatementNode
]

{ #category : #operations }
ViennaNarrowLetStatement >> execute [

	| dummy base |
	dummy := self replaceNode: ast with: ViennaDummyNode empty.
	base := ast statement.
	self replaceNode: self definitionNode with: ast.
	ast statement: self definitionNode.
	^ self replaceNode: dummy with: base
]

{ #category : #accessing }
ViennaNarrowLetStatement >> findDefinitionNode [

	| statement |
	(ast localDefinitionList allSatisfy: [ :localDefinition |
		 localDefinition isViennaValueDefinitionNode ]) ifFalse: [ ^ nil ].
	statement := self ast statement
		             narrowestStatementWithFreeIdentifiers:
		             ast localDefinitionList uniqueBoundIdentifiers.
	^ statement == self ast statement
		  ifTrue: [ nil ]
		  ifFalse: [ statement ]
]

{ #category : #accessing }
ViennaNarrowLetStatement >> sortingOrder [
	^ 3.51
]
