Class {
	#name : #ViennaOrNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaOrNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter or
]

{ #category : #accessing }
ViennaOrNode >> isViennaOrNode [

	^ true
]

{ #category : #accessing }
ViennaOrNode >> label [

	^ 'Or'
]

{ #category : #'pretty printing' }
ViennaOrNode >> operatorPrecedence [

	^ 13
]
