Class {
	#name : 'ViennaLetBeExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaLetBeExpressionNode class >> multipleBind: aViennaMultipleBindNode conditionExpression: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 3)
		  multipleBind: aViennaMultipleBindNode;
		  conditionExpression: aViennaExpressionNode1;
		  expression: aViennaExpressionNode2;
		  yourself
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> conditionExpression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> conditionExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> definitionOfLocalName: aString [

	| valDef |
	valDef := self first.
	valDef
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> expression [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> expression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : 'testing' }
ViennaLetBeExpressionNode >> findResolverForIdentifier: aString [

	^ (self multipleBind bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaLetBeExpressionNode >> formatWith: aViennaAbstractFormatter [

	| multipleBind guard expression |
	multipleBind := aViennaAbstractFormatter
		                indentString:
		                (aViennaAbstractFormatter keyword: 'let')
		                insertCrIfNeeded:
		                (aViennaAbstractFormatter format: self multipleBind).
	guard := self conditionExpression ifNil: [ '' ] ifNotNil: [ :node |
		         aViennaAbstractFormatter
			         indentString: (aViennaAbstractFormatter keyword: 'be st')
			         insertCrIfNeeded: (aViennaAbstractFormatter format: node) ].
	expression := aViennaAbstractFormatter
		              indentString: (aViennaAbstractFormatter keyword: 'in')
		              insertCrIfNeeded:
		              (aViennaAbstractFormatter format: self expression).
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: multipleBind
				   insertCrIfNeeded: guard)
		  insertCrIfNeeded: expression
]

{ #category : 'private' }
ViennaLetBeExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	self multipleBind freeIdentifiersExcept: aSet do: aBlock.
	boundIdentifiers := aSet , self multipleBind uniqueBoundIdentifiers.
	self conditionExpression
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	self expression freeIdentifiersExcept: boundIdentifiers do: aBlock
]

{ #category : 'testing' }
ViennaLetBeExpressionNode >> hasScope [

	^ true
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> isViennaLetBeExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> label [

	^ 'LetBeExpression'
]

{ #category : 'testing' }
ViennaLetBeExpressionNode >> lookupIdentifier: aString [

	^ (self multipleBind bindsIdentifier: aString)
		  ifTrue: [ self multipleBind ]
		  ifFalse: [ nil ]
]

{ #category : 'typechecking' }
ViennaLetBeExpressionNode >> maximalType [

	self multipleBind typecheck.
	self conditionExpression ifNotNil: [ :condition |
		condition typecheck: ViennaType bool ].
	^ self expression typecheck
]

{ #category : 'typechecking' }
ViennaLetBeExpressionNode >> maximalType: aViennaType [

	self multipleBind typecheck.
	self expression maximalType: aViennaType.
	super maximalType: aViennaType
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> multipleBind [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaLetBeExpressionNode >> multipleBind: aViennaMultipleBindNode [

	self at: 1 put: aViennaMultipleBindNode
]

{ #category : 'pretty printing' }
ViennaLetBeExpressionNode >> operatorPrecedence [

	^ 10
]
