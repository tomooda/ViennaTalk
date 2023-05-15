Class {
	#name : #ViennaImplyNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaImplyNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '=>'
]

{ #category : #'pretty printing' }
ViennaImplyNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaImplyNode >> label [

	^ 'Imply'
]

{ #category : #'pretty printing' }
ViennaImplyNode >> operatorPrecedence [

	^ 12
]