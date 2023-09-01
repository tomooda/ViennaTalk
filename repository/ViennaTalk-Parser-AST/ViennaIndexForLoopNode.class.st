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

{ #category : #'accessing-definitions' }
ViennaIndexForLoopNode >> findResolverForIdentifier: aString [

	^ self identifier = aString
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaIndexForLoopNode >> formatWith: aViennaAbstractFormatter [

	| identifier startExpression endExpression stepExpression statement |
	identifier := aViennaAbstractFormatter format: self identifier.
	startExpression := aViennaAbstractFormatter format:
		                   self startExpression.
	endExpression := aViennaAbstractFormatter format: self endExpression.
	stepExpression := self stepExpression
		                  ifNotNil: [ :node |
			                  aViennaAbstractFormatter
				                  indentString: 'by '
				                  insertCrIfNeeded:
				                  (aViennaAbstractFormatter format: node) ]
		                  ifNil: [ '' ].
	statement := aViennaAbstractFormatter format: self statement.
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

{ #category : #private }
ViennaIndexForLoopNode >> freeIdentifiersExcept: aSet do: aBlock [

	self startExpression freeIdentifiersExcept: aSet do: aBlock.
	self endExpression freeIdentifiersExcept: aSet do: aBlock.
	self stepExpression freeIdentifiersExcept: aSet do: aBlock.
	self statement
		freeIdentifiersExcept: (aSet copyWith: self identifier)
		do: aBlock
]

{ #category : #testing }
ViennaIndexForLoopNode >> hasScope [

	^ true
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

{ #category : #'accessing-definitions' }
ViennaIndexForLoopNode >> lookupIdentifier: aString [

	^ self identifier = aString ifTrue: [ self ]
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
