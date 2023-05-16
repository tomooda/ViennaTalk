Class {
	#name : #ViennaExpressionListNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExpressionListNode class >> withAll: anArrayOfViennaExpressionNode [

	| list |
	list := self new: anArrayOfViennaExpressionNode size.
	1 to: anArrayOfViennaExpressionNode size do: [ :index |
		list at: index put: (anArrayOfViennaExpressionNode at: index) ].
	^ list
]

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
