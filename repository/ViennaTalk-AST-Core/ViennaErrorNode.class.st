Class {
	#name : 'ViennaErrorNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaErrorNode class >> identifier: aString expression: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 3)
		  identifier: aString;
		  expression1: aViennaExpressionNode1;
		  expression2: aViennaExpressionNode2;
		  yourself
]

{ #category : 'private' }
ViennaErrorNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self
]

{ #category : 'accessing' }
ViennaErrorNode >> expression1 [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaErrorNode >> expression1: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaErrorNode >> expression2 [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaErrorNode >> expression2: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaErrorNode >> formatWith: aViennaAbstractFormatter [

	^ self identifier ++ ':'
	  ++ (aViennaAbstractFormatter format: self expression1) ++ '->'
	  ++ (aViennaAbstractFormatter format: self expression2)
]

{ #category : 'private' }
ViennaErrorNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression1 freeIdentifiersExcept: aSet do: aBlock.
	self expression2 freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'accessing' }
ViennaErrorNode >> identifier [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaErrorNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : 'testing' }
ViennaErrorNode >> isViennaErrorNode [

	^ true
]

{ #category : 'accessing' }
ViennaErrorNode >> label [

	^ 'Error'
]

{ #category : 'typechecking' }
ViennaErrorNode >> maximalType [

	self expression1 typecheck: ViennaType bool.
	self expression2 typecheck: ViennaType bool.
	^ ViennaType unit
]
