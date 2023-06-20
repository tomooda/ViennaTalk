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

{ #category : #private }
ViennaResultExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #testing }
ViennaResultExpressionNode >> isViennaResultExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaResultExpressionNode >> label [

	^ 'ResultExpression'
]
