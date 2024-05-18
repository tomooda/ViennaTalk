Class {
	#name : 'ViennaSequenceForLoopNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'as yet unclassified' }
ViennaSequenceForLoopNode class >> patternOrBind: aViennaPatternNodeOrViennaBindNode expression: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 3)
		  patternOrBind: aViennaPatternNodeOrViennaBindNode;
		  expression: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : 'accessing-definitions' }
ViennaSequenceForLoopNode >> definitionOfLocalName: aString [

	self patternOrBind
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaSequenceForLoopNode >> expression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaSequenceForLoopNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaSequenceForLoopNode >> findResolverForIdentifier: aString [

	^ (self patternOrBind bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaSequenceForLoopNode >> formatWith: aViennaAbstractFormatter [

	| patternBind expression statement |
	patternBind := aViennaAbstractFormatter format: self patternOrBind.
	expression := aViennaAbstractFormatter format: self expression.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: (aViennaAbstractFormatter
						    indentString: (aViennaAbstractFormatter keyword: 'for')
						    insertCrIfNeeded: patternBind)
				   insertCrIfNeeded: (aViennaAbstractFormatter
						    indentString: (aViennaAbstractFormatter keyword: 'in')
						    insertCrIfNeeded: expression))
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'do')
				   insertCrIfNeeded: statement)
]

{ #category : 'private' }
ViennaSequenceForLoopNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self patternOrBind freeIdentifiersExcept: aSet do: aBlock.
	self statement
		freeIdentifiersExcept:
		aSet , self patternOrBind uniqueBoundIdentifiers
		do: aBlock
]

{ #category : 'testing' }
ViennaSequenceForLoopNode >> hasScope [

	^ true
]

{ #category : 'testing' }
ViennaSequenceForLoopNode >> isViennaSequenceForLoopNode [

	^ true
]

{ #category : 'accessing' }
ViennaSequenceForLoopNode >> label [

	^ 'SequenceForLoop'
]

{ #category : 'accessing-definitions' }
ViennaSequenceForLoopNode >> lookupIdentifier: aString [

	| pattern |
	pattern := self patternOrBind pattern.
	(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ].
	^ nil
]

{ #category : 'typechecking' }
ViennaSequenceForLoopNode >> maximalType [

	self patternOrBind maximalType:
		(ViennaType normalFormUnion: (Array streamContents: [ :stream |
				  (self expression typecheck: ViennaType any seq)
					  possibleTypesDo: [ :type |
					  type isSeqType ifTrue: [ stream nextPut: type basetype ] ] ])).
	self patternOrBind typecheck: ViennaType any.
	^ self statement typecheck
]

{ #category : 'accessing' }
ViennaSequenceForLoopNode >> patternOrBind [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaSequenceForLoopNode >> patternOrBind: aViennaPatternNodeOrViennaBindNode [

	self at: 1 put: aViennaPatternNodeOrViennaBindNode
]

{ #category : 'accessing' }
ViennaSequenceForLoopNode >> statement [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaSequenceForLoopNode >> statement: aViennaStatementNode [

	self at: 3 put: aViennaStatementNode
]
