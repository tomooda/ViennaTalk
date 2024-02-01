Class {
	#name : #ViennaGreaterThanOrEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaGreaterThanOrEqualNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '>='
]

{ #category : #accessing }
ViennaGreaterThanOrEqualNode >> isViennaGreaterThanOrEqualNode [

	^ true
]

{ #category : #accessing }
ViennaGreaterThanOrEqualNode >> label [

	^ 'GreaterThanOrEqual'
]

{ #category : #'pretty printing' }
ViennaGreaterThanOrEqualNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaGreaterThanOrEqualNode >> paramType1 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaGreaterThanOrEqualNode >> paramType2 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaGreaterThanOrEqualNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
