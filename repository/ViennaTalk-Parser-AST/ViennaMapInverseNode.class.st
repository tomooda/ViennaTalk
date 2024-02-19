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

{ #category : #testing }
ViennaMapInverseNode >> isViennaMapInverseNode [

	^ true
]

{ #category : #accessing }
ViennaMapInverseNode >> label [

	^ 'MapInverse'
]

{ #category : #'pretty printing' }
ViennaMapInverseNode >> operatorPrecedence [

	^ 33
]

{ #category : #typechecking }
ViennaMapInverseNode >> paramType [

	^ ViennaType any inmapTo: ViennaType any
]

{ #category : #typechecking }
ViennaMapInverseNode >> returnTypeFor: aViennaType [

	^ aViennaType isInmapType
		  ifTrue: [ aViennaType valuetype inmapTo: aViennaType keytype ]
		  ifFalse: [ ViennaType unit ]
]
