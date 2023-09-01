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

	^ self expression
		  ifNotNil: [ :expression |
			  'exit ' , (aViennaAbstractFormatter indentString:
				   (aViennaAbstractFormatter format: expression)) ]
		  ifNil: [ 'exit' ]
]

{ #category : #private }
ViennaExitStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaExitStatementNode >> isViennaExitStatementNode [

	^ true
]

{ #category : #accessing }
ViennaExitStatementNode >> label [

	^ 'ExitStatement'
]
