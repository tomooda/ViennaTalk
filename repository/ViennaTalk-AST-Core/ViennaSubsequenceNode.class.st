Class {
	#name : #ViennaSubsequenceNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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

{ #category : #private }
ViennaSubsequenceNode >> freeIdentifiersExcept: aSet do: aBlock [

	self sequenceExpression freeIdentifiersExcept: aSet do: aBlock.
	self startExpression freeIdentifiersExcept: aSet do: aBlock.
	self endExpression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #'pretty printing' }
ViennaSubsequenceNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #testing }
ViennaSubsequenceNode >> isViennaSubsequenceNode [

	^ true
]

{ #category : #accessing }
ViennaSubsequenceNode >> label [

	^ 'Subsequence'
]

{ #category : #typechecking }
ViennaSubsequenceNode >> maximalType [

	| seqType |
	seqType := self sequenceExpression typecheck: ViennaType any seq.
	self startExpression typecheck: ViennaType nat1.
	self endExpression typecheck: ViennaType nat1.
	^ ViennaType normalFormUnion: (Array streamContents: [ :stream |
			   seqType possibleTypesDo: [ :type |
				   type isSeqType ifTrue: [ stream nextPut: type basetype seq ] ] ])
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
