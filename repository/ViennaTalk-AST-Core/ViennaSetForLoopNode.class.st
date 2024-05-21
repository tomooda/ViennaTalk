Class {
	#name : 'ViennaSetForLoopNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaSetForLoopNode class >> pattern: aViennaPatternNode expression: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 3)
		  pattern: aViennaPatternNode;
		  expression: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : 'accessing-definitions' }
ViennaSetForLoopNode >> definitionOfLocalName: aString [

	self pattern
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaSetForLoopNode >> expression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaSetForLoopNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaSetForLoopNode >> findResolverForIdentifier: aString [

	^ (self pattern bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaSetForLoopNode >> formatWith: aViennaAbstractFormatter [

	| pattern expression statement |
	pattern := aViennaAbstractFormatter format: self pattern.
	expression := aViennaAbstractFormatter format: self expression.
	statement := aViennaAbstractFormatter format: self statement.
	(aViennaAbstractFormatter needsIndent:
		 pattern ++ expression ++ statement) ifFalse: [
		^ (aViennaAbstractFormatter keyword: 'for all ') ++ pattern ++ ' '
		  ++ aViennaAbstractFormatter inset ++ ' ' ++ expression
		  ++ (aViennaAbstractFormatter keyword: ' do ') ++ statement ].
	(aViennaAbstractFormatter needsIndent: pattern ++ expression)
		ifFalse: [
			^ (aViennaAbstractFormatter keyword: 'for all ') ++ pattern ++ ' '
			  ++ (aViennaAbstractFormatter inset ++ ' ') ++ expression
			  ++ (aViennaAbstractFormatter keyword: ' do') ++ String cr
			  ++ aViennaAbstractFormatter indent
			  ++ (aViennaAbstractFormatter indentString: statement) ].
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: (aViennaAbstractFormatter
						    indentString: (aViennaAbstractFormatter keyword: 'for all')
						    insertCrIfNeeded: pattern)
				   insertCrIfNeeded: (aViennaAbstractFormatter
						    indentString: aViennaAbstractFormatter inset
						    insertCrIfNeeded: expression))
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'do')
				   insertCrIfNeeded: statement)
]

{ #category : 'private' }
ViennaSetForLoopNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self statement
		freeIdentifiersExcept: aSet , self pattern uniqueBoundIdentifiers
		do: aBlock
]

{ #category : 'testing' }
ViennaSetForLoopNode >> hasScope [

	^ true
]

{ #category : 'testing' }
ViennaSetForLoopNode >> isViennaSetForLoopNode [

	^ true
]

{ #category : 'accessing' }
ViennaSetForLoopNode >> label [

	^ 'SetForLoop'
]

{ #category : 'accessing-definitions' }
ViennaSetForLoopNode >> lookupIdentifier: aString [

	^ (self pattern bindsIdentifier: aString) ifTrue: [ self pattern ]
]

{ #category : 'typechecking' }
ViennaSetForLoopNode >> maximalType [

	self pattern maximalType:
		(ViennaType normalFormUnion: (Array streamContents: [ :stream |
				  (self expression typecheck: ViennaType any set)
					  possibleTypesDo: [ :type |
					  type isSetType ifTrue: [ stream nextPut: type basetype ] ] ])).
	self pattern typecheck: ViennaType any.
	^ self statement typecheck
]

{ #category : 'accessing' }
ViennaSetForLoopNode >> pattern [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaSetForLoopNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : 'accessing' }
ViennaSetForLoopNode >> statement [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaSetForLoopNode >> statement: aViennaStatementNode [

	self at: 3 put: aViennaStatementNode
]
