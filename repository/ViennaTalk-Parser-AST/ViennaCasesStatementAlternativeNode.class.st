Class {
	#name : #ViennaCasesStatementAlternativeNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCasesStatementAlternativeNode class >> patternList: aViennaPatternListNode statement: aViennaStatementNode [

	^ (self new: 2)
		  patternList: aViennaPatternListNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #private }
ViennaCasesStatementAlternativeNode >> boundIdentifiersInto: aSet [

	self patternList boundIdentifiersInto: aSet
]

{ #category : #'accessing-definitions' }
ViennaCasesStatementAlternativeNode >> definitionOfLocalName: aString [

	self patternList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
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
