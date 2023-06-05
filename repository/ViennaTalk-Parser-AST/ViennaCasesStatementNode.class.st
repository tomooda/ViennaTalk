Class {
	#name : #ViennaCasesStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCasesStatementNode class >> expression: aViennaExpressionNode casesStatementAlternatives: aViennaCasesStatementAlternativesNode othersStatement: aViennaOthersStatementNode [

	^ (self new: 3)
		  expression: aViennaExpressionNode;
		  casesStatementAlternatives: aViennaCasesStatementAlternativesNode;
		  othersStatement: aViennaOthersStatementNode;
		  yourself
]

{ #category : #accessing }
ViennaCasesStatementNode >> casesStatementAlternatives [

	^ self at: 2
]

{ #category : #accessing }
ViennaCasesStatementNode >> casesStatementAlternatives: aViennaCasesStatementAlternativesNode [

	self at: 2 put: aViennaCasesStatementAlternativesNode
]

{ #category : #accessing }
ViennaCasesStatementNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaCasesStatementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaCasesStatementNode >> formatWith: aViennaAbstractFormatter [

	| value alternatives others |
	value := aViennaAbstractFormatter format: self expression.
	alternatives := aViennaAbstractFormatter format:
		                self casesStatementAlternatives.
	others := self othersStatement
		          ifNil: [ '' ]
		          ifNotNil: [ :node |
		          ',' , String cr , (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter indentString:
		  'cases ' , value , ':' , String cr , alternatives , others
		  , String cr , 'end'
]

{ #category : #testing }
ViennaCasesStatementNode >> isViennaCasesStatementNode [

	^ true
]

{ #category : #accessing }
ViennaCasesStatementNode >> label [

	^ 'CasesStatement'
]

{ #category : #accessing }
ViennaCasesStatementNode >> othersStatement [

	^ self at: 3
]

{ #category : #accessing }
ViennaCasesStatementNode >> othersStatement: aViennaOthersStatementNode [

	self at: 3 put: aViennaOthersStatementNode
]
