Class {
	#name : #ViennaOthersExpressionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaOthersExpressionNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaOthersExpressionNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaOthersExpressionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaOthersExpressionNode >> formatWith: aViennaAbstractFormatter [

	| expression |
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: 'others ->'
		  insertCrIfNeeded: expression
]

{ #category : #accessing }
ViennaOthersExpressionNode >> label [

	^ 'OthersExpression'
]
