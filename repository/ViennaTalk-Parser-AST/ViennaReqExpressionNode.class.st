Class {
	#name : #ViennaReqExpressionNode,
	#superclass : #ViennaHistoryExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaReqExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ '#req(' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
]

{ #category : #accessing }
ViennaReqExpressionNode >> label [

	^ 'ReqExpression'
]
