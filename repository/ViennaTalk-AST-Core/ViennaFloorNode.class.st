Class {
	#name : 'ViennaFloorNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaFloorNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'floor'
]

{ #category : 'testing' }
ViennaFloorNode >> isViennaFloorNode [

	^ true
]

{ #category : 'accessing' }
ViennaFloorNode >> label [

	^ 'Floor'
]

{ #category : 'pretty printing' }
ViennaFloorNode >> operatorPrecedence [

	^ 36
]

{ #category : 'typechecking' }
ViennaFloorNode >> paramType [

	^ ViennaType real
]

{ #category : 'typechecking' }
ViennaFloorNode >> returnTypeFor: aViennaType [

	^ aViennaType isIntType
		  ifTrue: [ aViennaType ]
		  ifFalse: [ ViennaType int ]
]
