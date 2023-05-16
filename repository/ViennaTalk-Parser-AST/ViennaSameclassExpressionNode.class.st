Class {
	#name : #ViennaSameclassExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSameclassExpressionNode >> formatWith: aViennaAbstractFormatter [

	| cls expression |
	cls := aViennaAbstractFormatter format: self first.
	expression := aViennaAbstractFormatter format: self second.
	^ aViennaAbstractFormatter
		  indentString: 'sameclass(' , cls , ','
		  insertCrIfNeeded: expression , ')'
]

{ #category : #accessing }
ViennaSameclassExpressionNode >> label [

	^ 'SameclassExpression'
]
