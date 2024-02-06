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

{ #category : #accessing }
ViennaOrNode >> paramType1 [

	^ ViennaType bool
]

{ #category : #accessing }
ViennaOrNode >> paramType2 [

	^ ViennaType bool
]

{ #category : #accessing }
ViennaOrNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
