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
	dummy := self replaceNode: ast with: ViennaDummyNode empty.
	base := ast expression.
	self replaceNode: self definitionNode with: ast.
	ast expression: self definitionNode.
	^ self replaceNode: dummy with: base
]

{ #category : #accessing }
ViennaNarrowLetExpression >> findDefinitionNode [

	| paramNames |
	(ast localDefinitionList allSatisfy: [ :localDefinition |
		 localDefinition isViennaValueDefinitionNode ]) ifFalse: [ ^ nil ].
	paramNames := ast localDefinitionList uniqueBoundIdentifiers.
	^ (ast expression select: [ :node |
		   node isViennaNode and: [
			   node isViennaExpressionNode and: [
				   node uniqueFreeIdentifiers includesAnyOf: paramNames ] ] ])
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
