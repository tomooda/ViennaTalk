Class {
	#name : 'ViennaReturnStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaReturnStatementNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : 'accessing' }
ViennaReturnStatementNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaReturnStatementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaReturnStatementNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter keyword: 'return ') ++ (self expression
		   ifNil: [ aViennaAbstractFormatter empty ]
		   ifNotNil: [ :arg |
			   aViennaAbstractFormatter indentString:
				   (aViennaAbstractFormatter format: arg) ])
]

{ #category : 'private' }
ViennaReturnStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaReturnStatementNode >> isViennaReturnStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaReturnStatementNode >> label [

	^ 'ReturnStatement'
]

{ #category : 'typechecking' }
ViennaReturnStatementNode >> maximalType [

	| opReturnType |
	opReturnType := (self detectParent: #isOperationDefinition ifNone: [
		                 ^ ViennaTypeError
			                   on: self
			                   signal:
			                   'Return statement out of operation definition' ])
		                returnType typecheck.
	^ self expression
		  ifNotNil: [ :returnValue | returnValue typecheck: opReturnType ]
		  ifNil: [
			  opReturnType ifNotUnit: [
				  ViennaTypeError
					  on: self
					  signal: 'Return value in an operation with a unit return type' ] ]
]
