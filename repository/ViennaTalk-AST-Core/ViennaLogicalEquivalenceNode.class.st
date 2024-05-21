Class {
	#name : 'ViennaLogicalEquivalenceNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaLogicalEquivalenceNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter equiv
]

{ #category : 'accessing' }
ViennaLogicalEquivalenceNode >> isViennaLogicalEquivalenceNode [

	^ true
]

{ #category : 'accessing' }
ViennaLogicalEquivalenceNode >> label [

	^ 'LogicalEquivalence'
]

{ #category : 'pretty printing' }
ViennaLogicalEquivalenceNode >> operatorPrecedence [

	^ 11
]

{ #category : 'accessing' }
ViennaLogicalEquivalenceNode >> paramType1 [

	^ ViennaType bool
]

{ #category : 'accessing' }
ViennaLogicalEquivalenceNode >> paramType2 [

	^ ViennaType bool
]

{ #category : 'accessing' }
ViennaLogicalEquivalenceNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType bool
]
