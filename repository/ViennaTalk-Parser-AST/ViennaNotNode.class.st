Class {
	#name : #ViennaNotNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaNotNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter not
]

{ #category : #testing }
ViennaNotNode >> isViennaNotNode [

	^ true
]

{ #category : #accessing }
ViennaNotNode >> label [

	^ 'Not'
]

{ #category : #'pretty printing' }
ViennaNotNode >> operatorPrecedence [

	^ 15
]
