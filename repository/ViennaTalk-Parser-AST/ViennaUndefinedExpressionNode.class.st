Class {
	#name : #ViennaUndefinedExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaUndefinedExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ 'undefined'
]

{ #category : #accessing }
ViennaUndefinedExpressionNode >> isViennaUndefinedExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaUndefinedExpressionNode >> label [

	^ 'UndefinedExpression'
]
