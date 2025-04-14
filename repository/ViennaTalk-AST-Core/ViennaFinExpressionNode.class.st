Class {
	#name : 'ViennaFinExpressionNode',
	#superclass : 'ViennaHistoryExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaFinExpressionNode >> expressionName [

	^ '#fin'
]

{ #category : 'testing' }
ViennaFinExpressionNode >> isViennaFinExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaFinExpressionNode >> label [

	^ 'FinExpression'
]
