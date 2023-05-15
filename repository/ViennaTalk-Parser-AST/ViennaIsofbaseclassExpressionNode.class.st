Class {
	#name : #ViennaIsofbaseclassExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaIsofbaseclassExpressionNode >> formatWith: aViennaAbstractFormatter [

	| cls expression |
	cls := aViennaAbstractFormatter format: self first.
	expression := aViennaAbstractFormatter format: self second.
	^ aViennaAbstractFormatter
		  indentString: 'isofbaseclass(' , cls , ','
		  insertCrIfNeeded: expression , ')'
]

{ #category : #accessing }
ViennaIsofbaseclassExpressionNode >> label [

	^ 'IsofbaseclassExpression'
]
