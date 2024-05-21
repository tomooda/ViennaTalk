Class {
	#name : 'ViennaCompositionNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaCompositionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'comp'
]

{ #category : 'pretty printing' }
ViennaCompositionNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : 'accessing' }
ViennaCompositionNode >> isViennaCompositionNode [

	^ true
]

{ #category : 'accessing' }
ViennaCompositionNode >> label [

	^ 'Composition'
]

{ #category : 'pretty printing' }
ViennaCompositionNode >> operatorPrecedence [

	^ 51
]

{ #category : 'accessing' }
ViennaCompositionNode >> paramType1 [

	^ ViennaType any
]

{ #category : 'accessing' }
ViennaCompositionNode >> paramType2 [

	^ ViennaType any
]

{ #category : 'accessing' }
ViennaCompositionNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	aViennaType1 isFunctionType ifTrue: [
		| argtypes1 returntype1 |
		argtypes1 := aViennaType1 argtypes.
		returntype1 := aViennaType1 returntype.
		argtypes1 size = 1 ifTrue: [
			| argtype1 |
			argtype1 := argtypes1 first.
			aViennaType2 isFunctionType ifTrue: [
				| argtypes2 returntype2 |
				argtypes2 := aViennaType2 argtypes.
				returntype2 := aViennaType2 returntype.
				(argtype1 isCompatibleWith: returntype2) ifTrue: [
					^ ViennaType partialFunction: argtypes2 to: returntype1 ] ] ] ].
	aViennaType1 isMapType ifTrue: [
		| keytype1 valuetype1 |
		keytype1 := aViennaType1 keytype.
		valuetype1 := aViennaType1 valuetype.
		aViennaType2 isMapType ifTrue: [
			| keytype2 valuetype2 |
			keytype2 := aViennaType2 keytype.
			valuetype2 := aViennaType2 valuetype.
			(keytype1 isCompatibleWith: valuetype2) ifTrue: [
				^ ViennaType map: keytype2 to: valuetype1 ] ] ].
	^ ViennaTypeError on: self signal: 'Composition not applicable'
]
