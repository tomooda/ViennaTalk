Class {
	#name : #ViennaActExpressionNode,
	#superclass : #ViennaHistoryExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaActExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter act , '(' , (aViennaAbstractFormatter
		   join: ', '
		   withAll: (aViennaAbstractFormatter formatAll: self)) , ')'
]

{ #category : #accessing }
ViennaActExpressionNode >> label [

	^ 'ActExpression'
]
