Class {
	#name : #ViennaIndexForLoopNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIndexForLoopNode class >> identifier: aString startExpression: aViennaExpressionNode1 endExpression: aViennaExpressionNode2 stepExpression: aViennaExpressionNode3 statement: aViennaStatementNode [

	^ (self new: 5)
		  identifier: aString;
		  startExpression: aViennaExpressionNode1;
		  endExpression: aViennaExpressionNode2;
		  stepExpression: aViennaExpressionNode3;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaIndexForLoopNode >> definitionOfLocalName: aString [

	self identifier = aString ifTrue: [ ^ self ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaIndexForLoopNode >> endExpression [

	^ self at: 3
]

{ #category : #accessing }
ViennaIndexForLoopNode >> endExpression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaIndexForLoopNode >> formatWith: aViennaAbstractFormatter [

	| identifier startExpression endExpression stepExpression statement |
	identifier := aViennaAbstractFormatter format: self first.
	startExpression := aViennaAbstractFormatter format: self second.
	endExpression := aViennaAbstractFormatter format: self third.
	stepExpression := self fourth
		                  ifNotNil: [ :node |
			                  aViennaAbstractFormatter
				                  indentString: 'by '
				                  insertCrIfNeeded:
				                  (aViennaAbstractFormatter format: node) ]
		                  ifNil: [ '' ].
	statement := aViennaAbstractFormatter format: self fifth.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: (aViennaAbstractFormatter
						    indentString: 'for ' , identifier
						    insertCrIfNeeded: '= ' , startExpression)
				   insertCrIfNeeded: (aViennaAbstractFormatter
						    noIndentString: (aViennaAbstractFormatter
								     indentString: 'to '
								     insertCrIfNeeded: endExpression)
						    insertCrIfNeeded: stepExpression))
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: 'do'
				   insertCrIfNeeded: statement)
]

{ #category : #accessing }
ViennaIndexForLoopNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaIndexForLoopNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaIndexForLoopNode >> isViennaIndexForLoopNode [

	^ true
]

{ #category : #accessing }
ViennaIndexForLoopNode >> label [

	^ 'IndexForLoop'
]

{ #category : #accessing }
ViennaIndexForLoopNode >> startExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaIndexForLoopNode >> startExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaIndexForLoopNode >> statement [

	^ self at: 5
]

{ #category : #accessing }
ViennaIndexForLoopNode >> statement: aViennaStatementNode [

	self at: 5 put: aViennaStatementNode
]

{ #category : #accessing }
ViennaIndexForLoopNode >> stepExpression [

	^ self at: 4
]

{ #category : #accessing }
ViennaIndexForLoopNode >> stepExpression: aViennaExpressionNode [

	self at: 4 put: aViennaExpressionNode
]
