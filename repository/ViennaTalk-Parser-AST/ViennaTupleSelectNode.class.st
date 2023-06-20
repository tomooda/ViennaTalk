Class {
	#name : #ViennaTupleSelectNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTupleSelectNode class >> expression: aViennaExpressionNode index: aString [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  index: aString;
		  yourself
]

{ #category : #accessing }
ViennaTupleSelectNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaTupleSelectNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaTupleSelectNode >> formatWith: aViennaAbstractFormatter [

	| tuple int |
	tuple := aViennaAbstractFormatter format: self expression.
	int := aViennaAbstractFormatter format: self index.
	^ aViennaAbstractFormatter print: tuple infix: '.#' arg: int
]

{ #category : #private }
ViennaTupleSelectNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTupleSelectNode >> index [

	^ self at: 2
]

{ #category : #accessing }
ViennaTupleSelectNode >> index: aString [

	self at: 2 put: aString
]

{ #category : #testing }
ViennaTupleSelectNode >> isViennaTupleSelectNode [

	^ true
]

{ #category : #accessing }
ViennaTupleSelectNode >> label [

	^ 'TupleSelect'
]
