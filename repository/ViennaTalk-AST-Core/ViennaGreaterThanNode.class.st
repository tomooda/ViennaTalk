Class {
	#name : #ViennaGreaterThanNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaGreaterThanNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '>'
]

{ #category : #accessing }
ViennaGreaterThanNode >> isViennaGreaterThanNode [

	^ true
]

{ #category : #accessing }
ViennaGreaterThanNode >> label [

	^ 'GreaterThan'
]

{ #category : #'pretty printing' }
ViennaGreaterThanNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaGreaterThanNode >> paramType1 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaGreaterThanNode >> paramType2 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaGreaterThanNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
