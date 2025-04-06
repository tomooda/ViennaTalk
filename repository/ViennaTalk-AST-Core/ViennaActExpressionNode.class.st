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

{ #category : 'testing' }
ViennaActExpressionNode >> isViennaActExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaActExpressionNode >> label [

	^ 'ActExpression'
]
