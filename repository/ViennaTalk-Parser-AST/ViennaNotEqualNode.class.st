Class {
	#name : #ViennaNotEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaNotEqualNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter notEqual
]

{ #category : #accessing }
ViennaNotEqualNode >> isViennaNotEqualNode [

	^ true
]

{ #category : #accessing }
ViennaNotEqualNode >> label [

	^ 'NotEqual'
]

{ #category : #'pretty printing' }
ViennaNotEqualNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaNotEqualNode >> paramType1 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaNotEqualNode >> paramType2 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaNotEqualNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 isCompatibleWith: aViennaType2)
		  ifTrue: [ ViennaType bool ]
		  ifFalse: [ ViennaTypeError signalOn: self ]
]
