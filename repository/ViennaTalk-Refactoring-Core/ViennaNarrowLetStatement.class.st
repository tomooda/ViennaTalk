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

	| paramNames |
	paramNames := Set new: ast first size * 2.
	ast localDefinitionList do: [ :localDefinition |
		localDefinition valueDefinitionOrFunctionDefinition
			isViennaValueDefinitionNode
			ifTrue: [
				localDefinition valueDefinitionOrFunctionDefinition pattern
					allDescendantsDo: [ :node |
						node isViennaPatternIdentifierNode ifTrue: [
							paramNames add: node identifier ] ] ]
			ifFalse: [ ^ nil ] ].
	paramNames := paramNames asArray.
	^ (ast statement select: [ :node |
		   node isViennaNode and: [
			   node isViennaStatementNode and: [
				   paramNames anySatisfy: [ :param |
					   self hasFreeOccurrencesOf: param in: node ] ] ] ])
		  ifNotEmpty: [ :nodes |
			  nodes size = 1
				  ifTrue: [ nodes first ]
				  ifFalse: [ nil ] ]
		  ifEmpty: [ nil ]
]

{ #category : #accessing }
ViennaNarrowLetStatement >> sortingOrder [
	^ 3.51
]
