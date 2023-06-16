Class {
	#name : #ViennaNarrowLetExpression,
	#superclass : #ViennaNarrowLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaNarrowLetExpression >> acceptsNode: aViennaNode [

	^ aViennaNode isViennaLetExpressionNode
]

{ #category : #operations }
ViennaNarrowLetExpression >> execute [

	| dummy base |
	dummy := self replaceNode: ast with: (ViennaNode label: 'DUMMY').
	base := ast expression.
	self replaceNode: self definitionNode with: ast.
	ast expression: self definitionNode.
	^ self replaceNode: dummy with: base
]

{ #category : #accessing }
ViennaNarrowLetExpression >> findDefinitionNode [

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
	^ (ast expression select: [ :node |
		   node isViennaNode and: [
			   node isViennaExpressionNode and: [
				   paramNames anySatisfy: [ :param |
					   self hasFreeOccurrencesOf: param in: node ] ] ] ])
		  ifNotEmpty: [ :nodes |
			  nodes size = 1
				  ifTrue: [ nodes first ]
				  ifFalse: [ nil ] ]
		  ifEmpty: [ nil ]
]

{ #category : #accessing }
ViennaNarrowLetExpression >> sortingOrder [
	^ 3.52
]
