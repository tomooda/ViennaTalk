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

{ #category : #testing }
ViennaFinitePowerSetNode >> isViennaFinitePowerSetNode [

	^ true
]

{ #category : #accessing }
ViennaFinitePowerSetNode >> label [

	^ 'FinitePowerSet'
]

{ #category : #'pretty printing' }
ViennaFinitePowerSetNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaFinitePowerSetNode >> paramType [

	^ ViennaType any set
]

{ #category : #typechecking }
ViennaFinitePowerSetNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype set set1
]
