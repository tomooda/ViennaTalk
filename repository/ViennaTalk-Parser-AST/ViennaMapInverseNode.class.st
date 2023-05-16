Class {
	#name : #ViennaMapInverseNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapInverseNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ self shouldNotImplement
]

{ #category : #'pretty printing' }
ViennaMapInverseNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter inverse:
		  (aViennaAbstractFormatter format: self expression)
]

{ #category : #accessing }
ViennaMapInverseNode >> label [

	^ 'MapInverse'
]

{ #category : #'pretty printing' }
ViennaMapInverseNode >> operatorPrecedence [

	^ 33
]
