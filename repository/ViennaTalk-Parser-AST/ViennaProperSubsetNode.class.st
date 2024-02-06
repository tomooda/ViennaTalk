Class {
	#name : #ViennaProperSubsetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaProperSubsetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter psubset
]

{ #category : #accessing }
ViennaProperSubsetNode >> isViennaProperSubsetNode [

	^ true
]

{ #category : #accessing }
ViennaProperSubsetNode >> label [

	^ 'ProperSubset'
]

{ #category : #'pretty printing' }
ViennaProperSubsetNode >> operatorPrecedence [

	^ 21
]

{ #category : #accessing }
ViennaProperSubsetNode >> paramType1 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaProperSubsetNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaProperSubsetNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 basetype isCompatibleWith: aViennaType2 basetype)
		  ifTrue: [ ViennaType bool ]
		  ifFalse: [ ViennaTypeError signalOn: self ]
]
