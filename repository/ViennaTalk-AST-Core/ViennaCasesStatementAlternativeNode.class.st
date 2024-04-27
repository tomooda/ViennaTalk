Class {
	#name : #ViennaCasesStatementAlternativeNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaCasesStatementAlternativeNode class >> patternList: aViennaPatternListNode statement: aViennaStatementNode [

	^ (self new: 2)
		  patternList: aViennaPatternListNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #private }
ViennaCasesStatementAlternativeNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'accessing-definitions' }
ViennaCasesStatementAlternativeNode >> definitionOfLocalName: aString [

	self patternList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'accessing-definitions' }
ViennaCasesStatementAlternativeNode >> findResolverForIdentifier: aString [

	^ (self patternList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativeNode >> formatWith: aViennaAbstractFormatter [

	| patternList statement |
	patternList := aViennaAbstractFormatter format: self patternList.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  indentString: patternList , ' ' , aViennaAbstractFormatter arrow
		  insertCrIfNeeded: statement
]

{ #category : #private }
ViennaCasesStatementAlternativeNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternList freeIdentifiersExcept: aSet do: aBlock.
	self statement
		freeIdentifiersExcept:
		aSet , self patternList uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaCasesStatementAlternativeNode >> hasScope [

	^ true
]

{ #category : #testing }
ViennaCasesStatementAlternativeNode >> isViennaCasesStatementAlternativeNode [

	^ true
]

{ #category : #accessing }
ViennaCasesStatementAlternativeNode >> label [

	^ 'CasesStatementAlternative'
]

{ #category : #'accessing-definitions' }
ViennaCasesStatementAlternativeNode >> lookupIdentifier: aString [

	^ (self bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]

{ #category : #typechecking }
ViennaCasesStatementAlternativeNode >> maximalType [

	^ self statement typecheck
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativeNode >> patternList [

	^ self at: 1
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativeNode >> patternList: aViennaPatternListNode [

	self at: 1 put: aViennaPatternListNode
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativeNode >> statement [

	^ self at: 2
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativeNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
