Class {
	#name : #ViennaCasesStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
		          ifNil: [ aViennaAbstractFormatter empty ]
		          ifNotNil: [ :node |
			          aViennaAbstractFormatter empty ++ ','
			          ++ aViennaAbstractFormatter cr
			          ++ (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter indentString:
		  (aViennaAbstractFormatter keyword: 'cases ') ++ value ++ ':'
		  ++ aViennaAbstractFormatter cr ++ alternatives ++ others
		  ++ aViennaAbstractFormatter cr
		  ++ (aViennaAbstractFormatter keyword: 'end')
]

{ #category : #private }
ViennaCasesStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self casesStatementAlternatives
		freeIdentifiersExcept: aSet
		do: aBlock.
	self othersStatement ifNotNil: [ :others |
		others freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaCasesStatementNode >> isViennaCasesStatementNode [

	^ true
]

{ #category : #accessing }
ViennaCasesStatementNode >> label [

	^ 'CasesStatement'
]

{ #category : #typechecking }
ViennaCasesStatementNode >> maximalType [

	| caseType |
	caseType := self expression typecheck.
	self casesStatementAlternatives do: [ :alternative |
		alternative patternList do: [ :pattern |
			pattern maximalType: caseType ] ].
	^ self casesStatementAlternatives typecheck
	  +
	  (self othersStatement
		   ifNotNil: #typecheck
		   ifNil: [ ViennaType unit ])
]

{ #category : #accessing }
ViennaCasesStatementNode >> othersStatement [

	^ self at: 3
]

{ #category : #accessing }
ViennaCasesStatementNode >> othersStatement: aViennaOthersStatementNode [

	self at: 3 put: aViennaOthersStatementNode
]
