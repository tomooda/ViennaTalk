Class {
	#name : #ViennaLetBeExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLetBeExpressionNode class >> multipleBind: aViennaMultipleBindNode conditionExpression: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 3)
		  multipleBind: aViennaMultipleBindNode;
		  conditionExpression: aViennaExpressionNode1;
		  expression: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> conditionExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> conditionExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> definitionOfLocalName: aString [

	| valDef |
	valDef := self first.
	valDef
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> expression [

	^ self at: 3
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> expression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : #testing }
ViennaLetBeExpressionNode >> findResolverForIdentifier: aString [

	^ (self multipleBind bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaLetBeExpressionNode >> formatWith: aViennaAbstractFormatter [

	| multipleBind guard expression |
	multipleBind := aViennaAbstractFormatter
		                indentString: 'let'
		                insertCrIfNeeded:
		                (aViennaAbstractFormatter format: self multipleBind).
	guard := self conditionExpression ifNil: [ '' ] ifNotNil: [ :node |
		         aViennaAbstractFormatter
			         indentString: 'be st'
			         insertCrIfNeeded: (aViennaAbstractFormatter format: node) ].
	expression := aViennaAbstractFormatter
		              indentString: 'in'
		              insertCrIfNeeded:
		              (aViennaAbstractFormatter format: self expression).
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: multipleBind
				   insertCrIfNeeded: guard)
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaLetBeExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	self multipleBind freeIdentifiersExcept: aSet do: aBlock.
	boundIdentifiers := aSet , self multipleBind uniqueBoundIdentifiers.
	self conditionExpression
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	self expression freeIdentifiersExcept: boundIdentifiers do: aBlock
]

{ #category : #testing }
ViennaLetBeExpressionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> isViennaLetBeExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> label [

	^ 'LetBeExpression'
]

{ #category : #testing }
ViennaLetBeExpressionNode >> lookupIdentifier: aString [

	self multipleBind patternList do: [ :pattern |
		(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ] ].
	^ nil
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> multipleBind [

	^ self at: 1
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> multipleBind: aViennaMultipleBindNode [

	self at: 1 put: aViennaMultipleBindNode
]

{ #category : #'pretty printing' }
ViennaLetBeExpressionNode >> operatorPrecedence [

	^ 10
]
