Class {
	#name : 'ViennaExitStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaExitStatementNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : 'accessing' }
ViennaExitStatementNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaExitStatementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaExitStatementNode >> formatWith: aViennaAbstractFormatter [

	^ self expression
		  ifNotNil: [ :expression |
			  (aViennaAbstractFormatter keyword: 'exit ')
			  ++ (aViennaAbstractFormatter indentString:
					   (aViennaAbstractFormatter format: expression)) ]
		  ifNil: [ aViennaAbstractFormatter keyword: 'exit' ]
]

{ #category : 'private' }
ViennaExitStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaExitStatementNode >> isViennaExitStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaExitStatementNode >> label [

	^ 'ExitStatement'
]

{ #category : 'typechecking' }
ViennaExitStatementNode >> maximalType [

	self expression typecheck.
	^ ViennaType unit
]
