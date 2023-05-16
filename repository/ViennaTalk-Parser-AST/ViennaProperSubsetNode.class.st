Class {
	#name : #ViennaProperSubsetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaProperSubsetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter psubset
]

{ #category : #accessing }
ViennaProperSubsetNode >> label [

	^ 'ProperSubset'
]

{ #category : #'pretty printing' }
ViennaProperSubsetNode >> operatorPrecedence [

	^ 21
]
