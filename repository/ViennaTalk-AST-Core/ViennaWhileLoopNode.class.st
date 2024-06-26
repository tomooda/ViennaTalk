Class {
	#name : 'ViennaWhileLoopNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaWhileLoopNode class >> expression: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : 'accessing' }
ViennaWhileLoopNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaWhileLoopNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaWhileLoopNode >> formatWith: aViennaAbstractFormatter [

	| expression statement |
	expression := aViennaAbstractFormatter format: self expression.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'while')
				   insertCrIfNeeded: expression)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'do')
				   insertCrIfNeeded: statement)
]

{ #category : 'private' }
ViennaWhileLoopNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self statement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaWhileLoopNode >> isViennaWhileLoopNode [

	^ true
]

{ #category : 'accessing' }
ViennaWhileLoopNode >> label [

	^ 'WhileLoop'
]

{ #category : 'typechecking' }
ViennaWhileLoopNode >> maximalType [

	self expression typecheck: ViennaType bool.
	^ self statement typecheck
]

{ #category : 'accessing' }
ViennaWhileLoopNode >> statement [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaWhileLoopNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
