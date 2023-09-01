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

{ #category : #'accessing-definitions' }
ViennaSetForLoopNode >> findResolverForIdentifier: aString [

	^ (self pattern bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
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

{ #category : #private }
ViennaSetForLoopNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self statement
		freeIdentifiersExcept: aSet , self pattern uniqueBoundIdentifiers
		do: aBlock
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

{ #category : #'accessing-definitions' }
ViennaSetForLoopNode >> lookupIdentifier: aString [

	^ (self pattern bindsIdentifier: aString) ifTrue: [ self pattern ]
]

{ #category : #accessing }
ViennaSetForLoopNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaSetForLoopNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #'as yet unclassified' }
ViennaSetForLoopNode >> sliceWith: aViennaSlicer [

	| needsControl |
	needsControl := false.
	[
	| origin |
	origin := aViennaSlicer copy.
	aViennaSlicer branch
		value: [ :subslicer | subslicer ];
		value: [ :subslicer |
			self statement sliceWith: subslicer.
			subslicer onNode: self do: [  ] ];
		value: nil.
	aViennaSlicer agenda ~= origin agenda ] whileTrue: [
		needsControl := true ].
	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self pattern.
		aViennaSlicer read: self expression ].
	needsControl ifTrue: [ aViennaSlicer control: self expression ].
	self pattern sliceWith: aViennaSlicer.
	self expression sliceWith: aViennaSlicer
]

{ #category : #accessing }
ViennaSetForLoopNode >> statement [

	^ self at: 3
]

{ #category : #accessing }
ViennaSetForLoopNode >> statement: aViennaStatementNode [

	self at: 3 put: aViennaStatementNode
]
