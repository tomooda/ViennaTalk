Class {
	#name : 'ViennaAndNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaAndNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter and
]

{ #category : 'testing' }
ViennaAndNode >> isViennaAndNode [

	^ true
]

{ #category : 'accessing' }
ViennaAndNode >> label [

	^ 'And'
]

{ #category : 'pretty printing' }
ViennaAndNode >> operatorPrecedence [

	^ 14
]

{ #category : 'accessing' }
ViennaAndNode >> paramType1 [

	^ ViennaType bool
]

{ #category : 'accessing' }
ViennaAndNode >> paramType2 [

	^ ViennaType bool
]

{ #category : 'accessing' }
ViennaAndNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
