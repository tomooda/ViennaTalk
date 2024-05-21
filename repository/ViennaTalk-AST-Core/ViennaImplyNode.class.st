Class {
	#name : 'ViennaImplyNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaImplyNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '=>'
]

{ #category : 'pretty printing' }
ViennaImplyNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : 'accessing' }
ViennaImplyNode >> isViennaImplyNode [

	^ true
]

{ #category : 'accessing' }
ViennaImplyNode >> label [

	^ 'Imply'
]

{ #category : 'pretty printing' }
ViennaImplyNode >> operatorPrecedence [

	^ 12
]

{ #category : 'accessing' }
ViennaImplyNode >> paramType1 [

	^ ViennaType bool
]

{ #category : 'accessing' }
ViennaImplyNode >> paramType2 [

	^ ViennaType bool
]

{ #category : 'accessing' }
ViennaImplyNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
