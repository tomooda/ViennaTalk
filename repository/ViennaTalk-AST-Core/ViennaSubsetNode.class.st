Class {
	#name : #ViennaSubsetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaSubsetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter subset
]

{ #category : #accessing }
ViennaSubsetNode >> isViennaSubsetNode [

	^ true
]

{ #category : #accessing }
ViennaSubsetNode >> label [

	^ 'Subset'
]

{ #category : #'pretty printing' }
ViennaSubsetNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaSubsetNode >> paramType1 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaSubsetNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaSubsetNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 basetype isCompatibleWith: aViennaType2 basetype)
		  ifTrue: [ ViennaType bool ]
		  ifFalse: [ ViennaTypeError signalOn: self ]
]
