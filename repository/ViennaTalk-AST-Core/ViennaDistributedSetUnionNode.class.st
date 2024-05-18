Class {
	#name : 'ViennaDistributedSetUnionNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaDistributedSetUnionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter dunion
]

{ #category : 'accessing' }
ViennaDistributedSetUnionNode >> isViennaDistributedSetUnionNode [

	^ true
]

{ #category : 'accessing' }
ViennaDistributedSetUnionNode >> label [

	^ 'DistributedSetUnion'
]

{ #category : 'typechecking' }
ViennaDistributedSetUnionNode >> maximalType: aViennaType [

	self expression maximalType: aViennaType set.
	super maximalType: aViennaType
]

{ #category : 'pretty printing' }
ViennaDistributedSetUnionNode >> operatorPrecedence [

	^ 36
]

{ #category : 'typechecking' }
ViennaDistributedSetUnionNode >> paramType [

	^ ViennaType any set set
]

{ #category : 'typechecking' }
ViennaDistributedSetUnionNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype
]
