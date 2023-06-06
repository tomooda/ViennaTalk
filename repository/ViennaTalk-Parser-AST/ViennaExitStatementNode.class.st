Class {
	#name : #ViennaExitStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExitStatementNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaExitStatementNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaExitStatementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaExitStatementNode >> formatWith: aViennaAbstractFormatter [

	^ 'exit ' , (aViennaAbstractFormatter indentString:
		   (aViennaAbstractFormatter format: self expression))
]

{ #category : #testing }
ViennaExitStatementNode >> isViennaExitStatementNode [

	^ true
]

{ #category : #accessing }
ViennaExitStatementNode >> label [

	^ 'ExitStatement'
]
