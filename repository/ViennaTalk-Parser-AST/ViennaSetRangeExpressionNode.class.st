Class {
	#name : #ViennaSetRangeExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSetRangeExpressionNode class >> startExpression: aViennaExpressionNode1 endExpression: aViennaExpressionNode2 [

	^ (self new: 2)
		  startExpression: aViennaExpressionNode1;
		  endExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaSetRangeExpressionNode >> endExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaSetRangeExpressionNode >> endExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaSetRangeExpressionNode >> formatWith: aViennaAbstractFormatter [

	| startExpression endExpression |
	startExpression := aViennaAbstractFormatter format:
		                   self startExpression.
	endExpression := aViennaAbstractFormatter format: self endExpression.
	^ aViennaAbstractFormatter
		  noIndentString: '{' , startExpression , ','
		  insertCrIfNeeded:
		  aViennaAbstractFormatter dots , ', ' , endExpression , '}'
]

{ #category : #accessing }
ViennaSetRangeExpressionNode >> label [

	^ 'SetRangeExpression'
]

{ #category : #accessing }
ViennaSetRangeExpressionNode >> startExpression [

	^ self at: 1
]

{ #category : #accessing }
ViennaSetRangeExpressionNode >> startExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]
