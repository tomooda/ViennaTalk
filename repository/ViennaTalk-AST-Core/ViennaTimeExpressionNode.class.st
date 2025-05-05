Class {
	#name : 'ViennaTimeExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaTimeExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter keyword: 'time'
]

{ #category : 'private' }
ViennaTimeExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : 'testing' }
ViennaTimeExpressionNode >> isViennaTimeExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaTimeExpressionNode >> label [

	^ 'TimeExpression'
]

{ #category : 'typechecking' }
ViennaTimeExpressionNode >> maximalType [

	^ ViennaType nat
]
