Class {
	#name : 'ViennaIterateNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaIterateNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter iterate
]

{ #category : 'pretty printing' }
ViennaIterateNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : 'accessing' }
ViennaIterateNode >> isViennaIterateNode [

	^ true
]

{ #category : 'accessing' }
ViennaIterateNode >> label [

	^ 'Iterate'
]

{ #category : 'pretty printing' }
ViennaIterateNode >> operatorPrecedence [

	^ 52
]

{ #category : 'accessing' }
ViennaIterateNode >> paramType1 [

	^ ViennaType any
]

{ #category : 'accessing' }
ViennaIterateNode >> paramType2 [

	^ ViennaType real
]

{ #category : 'accessing' }
ViennaIterateNode >> returnTypeFor: type and: aViennaType2 [

	type isFunctionType ifTrue: [
		| argtypes |
		argtypes := type argtypes.
		(argtypes size = 1 and: [
			 type returntype isCompatibleWith: argtypes first ]) ifTrue: [
			^ type asPartialFunctionType ] ].
	type isMapType ifTrue: [
		(type keytype isCompatibleWith: type valuetype) ifTrue: [ ^ type ] ].
	type isRealType ifTrue: [ ^ ViennaType real ].
	^ ViennaTypeError signalOn: self
]
