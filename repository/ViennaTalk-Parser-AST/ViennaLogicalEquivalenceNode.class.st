Class {
	#name : #ViennaLogicalEquivalenceNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaLogicalEquivalenceNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter equiv
]

{ #category : #accessing }
ViennaLogicalEquivalenceNode >> isViennaLogicalEquivalenceNode [

	^ true
]

{ #category : #accessing }
ViennaLogicalEquivalenceNode >> label [

	^ 'LogicalEquivalence'
]

{ #category : #'pretty printing' }
ViennaLogicalEquivalenceNode >> operatorPrecedence [

	^ 11
]
