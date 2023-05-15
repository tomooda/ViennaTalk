Class {
	#name : #ViennaLetExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLetExpressionNode class >> localDefinitionList: aViennaLocalDefinitionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaLetExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaLetExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaLetExpressionNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitionList expression |
	localDefinitionList := aViennaAbstractFormatter format:
		                       self localDefinitionList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: 'let'
				   insertCrIfNeeded: localDefinitionList)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: 'in'
				   insertCrIfNeeded: expression)
]

{ #category : #accessing }
ViennaLetExpressionNode >> label [

	^ 'LetExpression'
]

{ #category : #accessing }
ViennaLetExpressionNode >> localDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaLetExpressionNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : #'pretty printing' }
ViennaLetExpressionNode >> operatorPrecedence [

	^ 10
]
