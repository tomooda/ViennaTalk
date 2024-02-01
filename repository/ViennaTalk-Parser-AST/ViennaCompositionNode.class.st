Class {
	#name : #ViennaCompositionNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaCompositionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'comp'
]

{ #category : #'pretty printing' }
ViennaCompositionNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaCompositionNode >> isViennaCompositionNode [

	^ true
]

{ #category : #accessing }
ViennaCompositionNode >> label [

	^ 'Composition'
]

{ #category : #'pretty printing' }
ViennaCompositionNode >> operatorPrecedence [

	^ 51
]

{ #category : #accessing }
ViennaCompositionNode >> paramType1 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaCompositionNode >> paramType2 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaCompositionNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| type1in type1out type2in type2out |
	(aViennaType1 isFunctionType or: [ aViennaType1 isOperationType ])
		ifTrue: [
			type1in := aViennaType1 argtypes.
			type1out := aViennaType1 returntype ]
		ifFalse: [
			aViennaType1 isMapType
				ifTrue: [
					type1in := { aViennaType1 keytype }.
					type1out := aViennaType1 valuetype ]
				ifFalse: [
					aViennaType1 isSeqType
						ifTrue: [
							type1in := { ViennaType nat1 }.
							type1out := aViennaType1 basetype ]
						ifFalse: [
							^ ViennaTypeError
								  on: self expression1
								  signal: 'Not an applicable type' ] ] ].

	(aViennaType2 isFunctionType or: [ aViennaType2 isOperationType ])
		ifTrue: [
			type2in := aViennaType2 argtypes.
			type2out := aViennaType2 returntype ]
		ifFalse: [
			aViennaType2 isMapType
				ifTrue: [
					type2in := { aViennaType2 keytype }.
					type2out := aViennaType2 valuetype ]
				ifFalse: [
					aViennaType2 isSeqType
						ifTrue: [
							type2in := { ViennaType nat1 }.
							type2out := aViennaType2 basetype ]
						ifFalse: [
							^ ViennaTypeError
								  on: self expression2
								  signal: 'Not an applicable type' ] ] ].

	type1in size = 1 ifFalse: [
		^ ViennaTypeError
			  on: self expression1
			  signal: 'Not an one-argument function' ].
	(type1in first isCompatibleWith: type2out) ifFalse: [
		^ ViennaTypeError
			  on: self
			  signal:
				  'Type mismatch between ' , type1in first printString , ' and '
				  , type2out printString ].
	^ (ViennaType product: type2in) -> type1out
]
