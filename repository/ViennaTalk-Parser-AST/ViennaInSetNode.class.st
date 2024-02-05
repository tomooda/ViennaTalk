Class {
	#name : #ViennaInSetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaInSetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter inset
]

{ #category : #accessing }
ViennaInSetNode >> isViennaInSetNode [

	^ true
]

{ #category : #accessing }
ViennaInSetNode >> label [

	^ 'InSet'
]

{ #category : #'pretty printing' }
ViennaInSetNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaInSetNode >> paramType1 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaInSetNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaInSetNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	(aViennaType1 isCompatibleWith: aViennaType2 basetype) ifFalse: [
		^ ViennaTypeError signalOn: self ].
	^ ViennaType bool
]
