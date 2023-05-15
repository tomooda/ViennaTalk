Class {
	#name : #ViennaIsofclassExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaIsofclassExpressionNode >> formatWith: aViennaAbstractFormatter [

	| cls expression |
	cls := aViennaAbstractFormatter format: self first.
	expression := aViennaAbstractFormatter format: self second.
	^ aViennaAbstractFormatter
		  indentString: 'isofclass(' , cls , ','
		  insertCrIfNeeded: expression , ')'
]

{ #category : #accessing }
ViennaIsofclassExpressionNode >> label [

	^ 'IsofclassExpression'
]
