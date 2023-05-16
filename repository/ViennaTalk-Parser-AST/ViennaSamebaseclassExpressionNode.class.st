Class {
	#name : #ViennaSamebaseclassExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSamebaseclassExpressionNode >> formatWith: aViennaAbstractFormatter [

	| cls expression |
	cls := aViennaAbstractFormatter format: self first.
	expression := aViennaAbstractFormatter format: self second.
	^ aViennaAbstractFormatter
		  indentString: 'samebaseclass(' , cls , ','
		  insertCrIfNeeded: expression , ')'
]

{ #category : #accessing }
ViennaSamebaseclassExpressionNode >> label [

	^ 'SamebaseclassExpression'
]
