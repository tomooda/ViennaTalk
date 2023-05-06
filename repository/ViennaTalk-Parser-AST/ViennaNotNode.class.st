Class {
	#name : #ViennaNotNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaNotNode >> label [

	^ 'Not'
]

{ #category : #'pretty printing' }
ViennaNotNode >> operatorPrecedence [

	^ 15
]
