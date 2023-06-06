Class {
	#name : #ViennaSequenceForLoopNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaSequenceForLoopNode class >> patternOrBind: aViennaPatternNodeOrViennaBindNode expression: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 3)
		  patternOrBind: aViennaPatternNodeOrViennaBindNode;
		  expression: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaSequenceForLoopNode >> definitionOfLocalName: aString [

	self patternOrBind
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaSequenceForLoopNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaSequenceForLoopNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaSequenceForLoopNode >> formatWith: aViennaAbstractFormatter [

	| patternBind expression statement |
	patternBind := aViennaAbstractFormatter format: self patternOrBind.
	expression := aViennaAbstractFormatter format: self expression.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: (aViennaAbstractFormatter
						    indentString: 'for'
						    insertCrIfNeeded: patternBind)
				   insertCrIfNeeded: (aViennaAbstractFormatter
						    indentString: 'in'
						    insertCrIfNeeded: expression))
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: 'do'
				   insertCrIfNeeded: statement)
]

{ #category : #testing }
ViennaSequenceForLoopNode >> isViennaSequenceForLoopNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceForLoopNode >> label [

	^ 'SequenceForLoop'
]

{ #category : #accessing }
ViennaSequenceForLoopNode >> patternOrBind [

	^ self at: 1
]

{ #category : #accessing }
ViennaSequenceForLoopNode >> patternOrBind: aViennaPatternNodeOrViennaBindNode [

	self at: 1 put: aViennaPatternNodeOrViennaBindNode
]

{ #category : #accessing }
ViennaSequenceForLoopNode >> statement [

	^ self at: 3
]

{ #category : #accessing }
ViennaSequenceForLoopNode >> statement: aViennaStatementNode [

	self at: 3 put: aViennaStatementNode
]
