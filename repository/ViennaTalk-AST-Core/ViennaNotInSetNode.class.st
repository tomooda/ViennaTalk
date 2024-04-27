Class {
	#name : #ViennaNotInSetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaNotInSetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter notInSet
]

{ #category : #accessing }
ViennaNotInSetNode >> isViennaNotInSetNode [

	^ true
]

{ #category : #accessing }
ViennaNotInSetNode >> label [

	^ 'NotInSet'
]

{ #category : #'pretty printing' }
ViennaNotInSetNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaNotInSetNode >> paramType1 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaNotInSetNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaNotInSetNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 isCompatibleWith: aViennaType2 basetype)
		  ifTrue: [ ViennaType bool ]
		  ifFalse: [ ViennaTypeError signalOn: self ]
]
