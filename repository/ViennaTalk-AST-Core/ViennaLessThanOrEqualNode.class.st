Class {
	#name : 'ViennaLessThanOrEqualNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaLessThanOrEqualNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '<='
]

{ #category : 'accessing' }
ViennaLessThanOrEqualNode >> isViennaLessThanOrEqualNode [

	^ true
]

{ #category : 'accessing' }
ViennaLessThanOrEqualNode >> label [

	^ 'LessThanOrEqual'
]

{ #category : 'pretty printing' }
ViennaLessThanOrEqualNode >> operatorPrecedence [

	^ 21
]

{ #category : 'accessing' }
ViennaLessThanOrEqualNode >> paramType1 [

	^ ViennaType real
]

{ #category : 'accessing' }
ViennaLessThanOrEqualNode >> paramType2 [

	^ ViennaType real
]

{ #category : 'accessing' }
ViennaLessThanOrEqualNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
