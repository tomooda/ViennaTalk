Class {
	#name : #ViennaIterateNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaIterateNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter iterate
]

{ #category : #'pretty printing' }
ViennaIterateNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaIterateNode >> isViennaIterateNode [

	^ true
]

{ #category : #accessing }
ViennaIterateNode >> label [

	^ 'Iterate'
]

{ #category : #'pretty printing' }
ViennaIterateNode >> operatorPrecedence [

	^ 52
]

{ #category : #accessing }
ViennaIterateNode >> paramType1 [

	^ ViennaType any
]

{ #category : #accessing }
ViennaIterateNode >> paramType2 [

	^ ViennaType nat1
]

{ #category : #accessing }
ViennaIterateNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| type |
	(aViennaType1 isFunctionType or: [ aViennaType1 isOperationType ])
		ifTrue: [
			| argtypes |
			argtypes := aViennaType1 argtypes.
			argtypes size = 1 ifFalse: [
				^ ViennaTypeError on: self signal: 'Not an one-argument function' ].
			(argtypes first isCompatibleWith: aViennaType1 returntype)
				ifFalse: [
					^ ViennaTypeError
						  on: self
						  signal: 'Type mismatch betweeen arg type and return type' ].
			aViennaType2 isNatType ifFalse: [
				^ ViennaTypeError
					  on: self
					  signal:
						  'Type mismatch: nat expected, but ' , aViennaType2 printString
						  , ' given' ].
			type := aViennaType1 returntype ]
		ifFalse: [
			aViennaType1 isMapType
				ifTrue: [
					(aViennaType1 keytype isCompatibleWith: aViennaType1 valuetype)
						ifFalse: [
							^ ViennaTypeError
								  on: self
								  signal: 'Type mismatch betweeen key type and value type' ].
					aViennaType2 isNatType ifFalse: [
						^ ViennaTypeError
							  on: self
							  signal:
								  'Type mismatch: nat expected, but '
								  , aViennaType2 printString , ' given' ].
					type := aViennaType1 valuetype ]
				ifFalse: [
					aViennaType1 isRealType
						ifTrue: [
							aViennaType2 isRealType ifFalse: [
								^ ViennaTypeError
									  on: self
									  signal:
										  'Type mismatch: real expected, but '
										  , aViennaType2 printString , ' given' ].
							type := ViennaType real ]
						ifFalse: [
							^ ViennaTypeError
								  on: self expression1
								  signal: 'Not an applicable type' ] ] ].

	^ type
]
