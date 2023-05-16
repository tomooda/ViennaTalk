Class {
	#name : #ViennaSubsequenceNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSubsequenceNode class >> sequenceExpression: aViennaExpression1 startExpression: aViennaExpression2 endExpression: aViennaExpression3 [

	^ (self new: 3)
		  sequenceExpression: aViennaExpression1;
		  startExpression: aViennaExpression2;
		  endExpression: aViennaExpression3;
		  yourself
]

{ #category : #accessing }
ViennaSubsequenceNode >> endExpression [

	^ self at: 3
]

{ #category : #accessing }
ViennaSubsequenceNode >> endExpression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaSubsequenceNode >> formatWith: aViennaAbstractFormatter [

	| sequence startExpression endExpression |
	sequence := aViennaAbstractFormatter format: self sequenceExpression.
	startExpression := aViennaAbstractFormatter format:
		                   self startExpression.
	endExpression := aViennaAbstractFormatter format: self endExpression.
	(aViennaAbstractFormatter needsIndent:
		 sequence , startExpression , endExpression) ifFalse: [
		^ sequence , '(' , startExpression , ','
		  , aViennaAbstractFormatter dots , ',' , endExpression , ')' ].
	(aViennaAbstractFormatter needsIndent:
		 startExpression , endExpression) ifFalse: [
		^ sequence , '(' , String cr , aViennaAbstractFormatter indent
		  , (aViennaAbstractFormatter indentString:
				   startExpression , ',' , aViennaAbstractFormatter dots , ', '
				   , endExpression , ')') ].
	^ sequence , '(' , String cr , aViennaAbstractFormatter indent
	  , ((aViennaAbstractFormatter indentString: startExpression , ',')
		   , String cr , aViennaAbstractFormatter indent
		   , aViennaAbstractFormatter dots , ', '
		   , (aViennaAbstractFormatter indentString: endExpression , ')'))
]

{ #category : #'pretty printing' }
ViennaSubsequenceNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaSubsequenceNode >> label [

	^ 'Subsequence'
]

{ #category : #'pretty printing' }
ViennaSubsequenceNode >> operatorPrecedence [

	^ 40
]

{ #category : #accessing }
ViennaSubsequenceNode >> sequenceExpression [

	^ self at: 1
]

{ #category : #accessing }
ViennaSubsequenceNode >> sequenceExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaSubsequenceNode >> startExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaSubsequenceNode >> startExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
