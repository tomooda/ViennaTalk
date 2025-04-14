Class {
	#name : 'ViennaActExpressionNode',
	#superclass : 'ViennaHistoryExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaActExpressionNode >> expressionName [

	^ '#act'
]

{ #category : 'as yet unclassified' }
ViennaActExpressionNode >> isViennaActExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaActExpressionNode >> label [

	^ 'ActExpression'
]
