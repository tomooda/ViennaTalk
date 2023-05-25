Class {
	#name : #ViennaCompositionNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaCompositionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'comp'
]

{ #category : #'pretty printing' }
ViennaCompositionNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaCompositionNode >> isViennaCompositionNode [

	^ true
]

{ #category : #accessing }
ViennaCompositionNode >> label [

	^ 'Composition'
]

{ #category : #'pretty printing' }
ViennaCompositionNode >> operatorPrecedence [

	^ 51
]
