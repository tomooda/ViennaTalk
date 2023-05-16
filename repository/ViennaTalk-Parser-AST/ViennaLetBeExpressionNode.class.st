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
ViennaLetBeExpressionNode >> expression [

	^ self at: 3
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> expression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
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

{ #category : #accessing }
ViennaLetBeExpressionNode >> label [

	^ 'LetBeExpression'
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
