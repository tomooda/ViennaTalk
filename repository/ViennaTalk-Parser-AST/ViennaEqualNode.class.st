Class {
	#name : #ViennaEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaEqualNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '='
]

{ #category : #accessing }
ViennaEqualNode >> isViennaEqualNode [

	^ true
]

{ #category : #accessing }
ViennaEqualNode >> label [

	^ 'Equal'
]

{ #category : #'pretty printing' }
ViennaEqualNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaEqualNode >> paramType1 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaEqualNode >> paramType2 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaEqualNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	(aViennaType1 isCompatibleWith: aViennaType2) ifFalse: [
		^ ViennaTypeError
			  on: self
			  signal:
				  'Type mismatch between ' , aViennaType1 printString , ' and '
				  , aViennaType2 printString ].
	^ ViennaType bool
]
