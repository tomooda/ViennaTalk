Class {
	#name : #ViennaResultExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaResultExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ 'RESULT'
]

{ #category : #testing }
ViennaResultExpressionNode >> isViennaResultExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaResultExpressionNode >> label [

	^ 'ResultExpression'
]
