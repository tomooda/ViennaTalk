Class {
	#name : #ViennaWaitingExpressionNode,
	#superclass : #ViennaHistoryExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaWaitingExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ '#waiting(' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
]

{ #category : #accessing }
ViennaWaitingExpressionNode >> label [

	^ 'WaitingExpression'
]
