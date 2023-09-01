Class {
	#name : #ViennaIterateNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaIterateNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter iterate
]

{ #category : #'pretty printing' }
ViennaIterateNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaIterateNode >> isViennaIterateNode [

	^ true
]

{ #category : #accessing }
ViennaIterateNode >> label [

	^ 'Iterate'
]

{ #category : #'pretty printing' }
ViennaIterateNode >> operatorPrecedence [

	^ 52
]
