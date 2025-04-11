Class {
	#name : 'ViennaUndefinedExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaUndefinedExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter keyword: 'undefined'
]

{ #category : 'private' }
ViennaUndefinedExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : 'accessing' }
ViennaUndefinedExpressionNode >> isViennaUndefinedExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaUndefinedExpressionNode >> label [

	^ 'UndefinedExpression'
]

{ #category : 'typechecking' }
ViennaUndefinedExpressionNode >> maximalType [

	^ ViennaType any
]
