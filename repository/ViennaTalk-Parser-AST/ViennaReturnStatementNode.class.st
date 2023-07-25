Class {
	#name : #ViennaReturnStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaReturnStatementNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaReturnStatementNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaReturnStatementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaReturnStatementNode >> formatWith: aViennaAbstractFormatter [

	^ 'return ' , (self expression ifNil: [ '' ] ifNotNil: [ :arg |
		   aViennaAbstractFormatter indentString:
			   (aViennaAbstractFormatter format: arg) ])
]

{ #category : #private }
ViennaReturnStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaReturnStatementNode >> isViennaReturnStatementNode [

	^ true
]

{ #category : #accessing }
ViennaReturnStatementNode >> label [

	^ 'ReturnStatement'
]

{ #category : #'as yet unclassified' }
ViennaReturnStatementNode >> sliceWith: aViennaSlicer [

	self expression sliceWith: self expression.
	aViennaSlicer onNode: self do: [ aViennaSlicer write: self ]
]
