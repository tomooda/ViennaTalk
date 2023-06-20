Class {
	#name : #ViennaExpressionListNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExpressionListNode >> boundIdentifiersDo: aBlock [

	
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

{ #category : #testing }
ViennaExpressionListNode >> isViennaExpressionListNode [

	^ true
]

{ #category : #accessing }
ViennaExpressionListNode >> label [

	^ 'ExpressionList'
]
