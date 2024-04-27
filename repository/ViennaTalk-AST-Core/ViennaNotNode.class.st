Class {
	#name : #ViennaNotNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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

{ #category : #typechecking }
ViennaNotNode >> paramType [

	^ ViennaType bool
]

{ #category : #typechecking }
ViennaNotNode >> returnTypeFor: aViennaType [

	^ ViennaType bool
]
