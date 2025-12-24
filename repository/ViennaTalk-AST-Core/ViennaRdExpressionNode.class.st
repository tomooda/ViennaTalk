Class {
	#name : 'ViennaRdExpressionNode',
	#superclass : 'ViennaHistoryExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaRdExpressionNode >> expressionName [

	^ '#rd'
]

{ #category : 'testing' }
ViennaRdExpressionNode >> isViennaRdExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaRdExpressionNode >> label [

	^ 'RdExpression'
]
