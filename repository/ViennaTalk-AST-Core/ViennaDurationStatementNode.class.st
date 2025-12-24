Class {
	#name : 'ViennaDurationStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaDurationStatementNode class >> expression: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : 'accessing' }
ViennaDurationStatementNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaDurationStatementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaDurationStatementNode >> formatWith: aViennaAbstractFormatter [

	| expression statement |
	expression := aViennaAbstractFormatter format: self expression.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  indentString:
			  (aViennaAbstractFormatter keyword: 'duration') ++ '('
			  ++ expression ++ ') '
		  insertCrIfNeeded: statement
]

{ #category : 'private' }
ViennaDurationStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self statement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaDurationStatementNode >> isViennaDurationStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaDurationStatementNode >> label [

	^ 'DurationStatement'
]

{ #category : 'typechecking' }
ViennaDurationStatementNode >> maximalType [

	self expression typecheck: ViennaType nat.
	^ self statement typecheck
]

{ #category : 'accessing' }
ViennaDurationStatementNode >> statement [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaDurationStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
