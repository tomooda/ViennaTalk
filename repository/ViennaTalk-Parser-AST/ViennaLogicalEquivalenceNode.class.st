Class {
	#name : #ViennaLogicalEquivalenceNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaLogicalEquivalenceNode >> label [

	^ 'LogicalEquivalence'
]

{ #category : #'pretty printing' }
ViennaLogicalEquivalenceNode >> operatorPrecedence [

	^ 11
]
