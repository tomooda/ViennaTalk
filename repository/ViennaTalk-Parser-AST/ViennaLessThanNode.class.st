Class {
	#name : #ViennaLessThanNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaLessThanNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '<'
]

{ #category : #accessing }
ViennaLessThanNode >> isViennaLessThanNode [

	^ true
]

{ #category : #accessing }
ViennaLessThanNode >> label [

	^ 'LessThan'
]

{ #category : #'pretty printing' }
ViennaLessThanNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaLessThanNode >> paramType1 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaLessThanNode >> paramType2 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaLessThanNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
