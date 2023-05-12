Class {
	#name : #ViennaFinitePowerSetNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaFinitePowerSetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter power
]

{ #category : #accessing }
ViennaFinitePowerSetNode >> label [

	^ 'FinitePowerSet'
]

{ #category : #'pretty printing' }
ViennaFinitePowerSetNode >> operatorPrecedence [

	^ 36
]
