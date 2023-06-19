Class {
	#name : #ViennaSetForLoopNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSetForLoopNode class >> pattern: aViennaPatternNode expression: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 3)
		  pattern: aViennaPatternNode;
		  expression: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaSetForLoopNode >> definitionOfLocalName: aString [

	self pattern
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaSetForLoopNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaSetForLoopNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaSetForLoopNode >> formatWith: aViennaAbstractFormatter [

	| pattern expression statement |
	pattern := aViennaAbstractFormatter format: self pattern.
	expression := aViennaAbstractFormatter format: self expression.
	statement := aViennaAbstractFormatter format: self statement.
	(aViennaAbstractFormatter needsIndent:
		 pattern , expression , statement) ifFalse: [
		^ 'for all ' , pattern , ' ' , aViennaAbstractFormatter inset , ' '
		  , expression , ' do ' , statement ].
	(aViennaAbstractFormatter needsIndent: pattern , expression)
		ifFalse: [
			^ 'for all ' , pattern , ' in set ' , expression , ' do'
			  , String cr , aViennaAbstractFormatter indent
			  , (aViennaAbstractFormatter indentString: statement) ].
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: (aViennaAbstractFormatter
						    indentString: 'for all'
						    insertCrIfNeeded: pattern)
				   insertCrIfNeeded: (aViennaAbstractFormatter
						    indentString: 'in set'
						    insertCrIfNeeded: expression))
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: 'do'
				   insertCrIfNeeded: statement)
]

{ #category : #testing }
ViennaSetForLoopNode >> hasScope [

	^ true
]

{ #category : #testing }
ViennaSetForLoopNode >> isViennaSetForLoopNode [

	^ true
]

{ #category : #accessing }
ViennaSetForLoopNode >> label [

	^ 'SetForLoop'
]

{ #category : #accessing }
ViennaSetForLoopNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaSetForLoopNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #accessing }
ViennaSetForLoopNode >> statement [

	^ self at: 3
]

{ #category : #accessing }
ViennaSetForLoopNode >> statement: aViennaStatementNode [

	self at: 3 put: aViennaStatementNode
]
