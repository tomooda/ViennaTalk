Class {
	#name : #ViennaNotInSetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaNotInSetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter notInSet
]

{ #category : #accessing }
ViennaNotInSetNode >> isViennaNotInSetNode [

	^ true
]

{ #category : #accessing }
ViennaNotInSetNode >> label [

	^ 'NotInSet'
]

{ #category : #'pretty printing' }
ViennaNotInSetNode >> operatorPrecedence [

	^ 21
]
