Class {
	#name : #ViennaExpressionListNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaExpressionListNode >> formatWith: aViennaAbstractFormatter [

	| expressions |
	expressions := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join:
			  ',' , ((aViennaAbstractFormatter anyNeedsIndent: expressions)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: expressions
]

{ #category : #accessing }
ViennaExpressionListNode >> label [

	^ 'ExpressionList'
]
