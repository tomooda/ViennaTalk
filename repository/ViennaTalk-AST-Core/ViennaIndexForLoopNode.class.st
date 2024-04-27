Class {
	#name : #ViennaIndexForLoopNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaIndexForLoopNode class >> patternIdentifier: aString startExpression: aViennaExpressionNode1 endExpression: aViennaExpressionNode2 stepExpression: aViennaExpressionNode3 statement: aViennaStatementNode [

	^ (self new: 5)
		  patternIdentifier: aString;
		  startExpression: aViennaExpressionNode1;
		  endExpression: aViennaExpressionNode2;
		  stepExpression: aViennaExpressionNode3;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaIndexForLoopNode >> definitionOfLocalName: aString [

	self identifier = aString ifTrue: [ ^ self patternIdentifier ].
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
	identifier := aViennaAbstractFormatter identifier: self identifier.
	startExpression := aViennaAbstractFormatter format:
		                   self startExpression.
	endExpression := aViennaAbstractFormatter format: self endExpression.
	stepExpression := self stepExpression
		                  ifNotNil: [ :node |
			                  aViennaAbstractFormatter
				                  indentString:
				                  (aViennaAbstractFormatter keyword: 'by ')
				                  insertCrIfNeeded:
				                  (aViennaAbstractFormatter format: node) ]
		                  ifNil: [ '' ].
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: (aViennaAbstractFormatter
						    indentString:
						    (aViennaAbstractFormatter keyword: 'for ') ++ identifier
						    insertCrIfNeeded: '= ' ++ startExpression)
				   insertCrIfNeeded: (aViennaAbstractFormatter
						    noIndentString: (aViennaAbstractFormatter
								     indentString: (aViennaAbstractFormatter keyword: 'to ')
								     insertCrIfNeeded: endExpression)
						    insertCrIfNeeded: stepExpression))
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'do')
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

	^ self patternIdentifier identifier
]

{ #category : #accessing }
ViennaIndexForLoopNode >> identifier: aString [

	self patternIdentifier identifier: aString
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

{ #category : #typechecking }
ViennaIndexForLoopNode >> maximalType [

	| indexType |
	indexType := (self startExpression typecheck: ViennaType real)
	             + (self endExpression typecheck: ViennaType real).
	self stepExpression ifNotNil: [ :exp |
		| stepType |
		stepType := exp typecheck: ViennaType real.
		(indexType isIntType and: [ stepType isIntType ]) ifFalse: [
			indexType := indexType + stepType ] ].
	self patternIdentifier maximalType: indexType.
	^ self statement typecheck
]

{ #category : #accessing }
ViennaIndexForLoopNode >> patternIdentifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaIndexForLoopNode >> patternIdentifier: aString [

	self at: 1 put: aString
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
