Class {
	#name : 'ViennaWrExpressionNode',
	#superclass : 'ViennaHistoryExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaWrExpressionNode >> expressionName [

	^ '#wr'
]

{ #category : 'testing' }
ViennaWrExpressionNode >> isViennaWrExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaWrExpressionNode >> label [

	^ 'WrExpression'
]
