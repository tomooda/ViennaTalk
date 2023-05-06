Class {
	#name : #ViennaSetUnionNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSetUnionNode >> label [

	^ 'SetUnion'
]

{ #category : #'pretty printing' }
ViennaSetUnionNode >> operatorPrecedence [

	^ 31
]
