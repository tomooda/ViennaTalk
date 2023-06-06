Class {
	#name : #ViennaLetBeStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLetBeStatementNode class >> multipleBind: aViennaMultipleBindNode conditionExpression: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 3)
		  multipleBind: aViennaMultipleBindNode;
		  conditionExpression: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #accessing }
ViennaLetBeStatementNode >> conditionExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaLetBeStatementNode >> conditionExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaLetBeStatementNode >> definitionOfLocalName: aString [

	| multipleBind |
	multipleBind := self multipleBind.
	multipleBind
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'pretty printing' }
ViennaLetBeStatementNode >> formatWith: aViennaAbstractFormatter [

	| multipleBind guard statement |
	multipleBind := aViennaAbstractFormatter
		                indentString: 'let'
		                insertCrIfNeeded:
		                (aViennaAbstractFormatter format: self multipleBind).
	guard := self conditionExpression ifNil: [ '' ] ifNotNil: [ :node |
		         aViennaAbstractFormatter
			         indentString: 'be st'
			         insertCrIfNeeded: (aViennaAbstractFormatter format: node) ].
	statement := aViennaAbstractFormatter
		             indentString: 'in'
		             insertCrIfNeeded:
		             (aViennaAbstractFormatter format: self statement).
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: multipleBind
				   insertCrIfNeeded: guard)
		  insertCrIfNeeded: statement
]

{ #category : #testing }
ViennaLetBeStatementNode >> isViennaLetBeStatementNode [

	^ true
]

{ #category : #accessing }
ViennaLetBeStatementNode >> label [

	^ 'LetBeStatement'
]

{ #category : #accessing }
ViennaLetBeStatementNode >> multipleBind [

	^ self at: 1
]

{ #category : #accessing }
ViennaLetBeStatementNode >> multipleBind: aViennaMultipleBindNode [

	self at: 1 put: aViennaMultipleBindNode
]

{ #category : #accessing }
ViennaLetBeStatementNode >> statement [

	^ self at: 3
]

{ #category : #accessing }
ViennaLetBeStatementNode >> statement: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]
