Class {
	#name : #ViennaNotInSetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaNotInSetNode >> label [

	^ 'NotInSet'
]

{ #category : #'pretty printing' }
ViennaNotInSetNode >> operatorPrecedence [

	^ 21
]
