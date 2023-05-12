Class {
	#name : #ViennaFinExpressionNode,
	#superclass : #ViennaHistoryExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaFinExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ '#fin(' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
]

{ #category : #accessing }
ViennaFinExpressionNode >> label [

	^ 'FinExpression'
]
