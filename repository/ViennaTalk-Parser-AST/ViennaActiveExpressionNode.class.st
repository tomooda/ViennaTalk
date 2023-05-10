Class {
	#name : #ViennaActiveExpressionNode,
	#superclass : #ViennaHistoryExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaActiveExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ '#active(' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
]

{ #category : #accessing }
ViennaActiveExpressionNode >> label [

	^ 'ActiveExpression'
]
