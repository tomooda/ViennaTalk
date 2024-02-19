Class {
	#name : #ViennaMapRangeNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapRangeNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'rng'
]

{ #category : #accessing }
ViennaMapRangeNode >> isViennaMapRangeNode [

	^ true
]

{ #category : #accessing }
ViennaMapRangeNode >> label [

	^ 'MapRange'
]

{ #category : #'pretty printing' }
ViennaMapRangeNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaMapRangeNode >> paramType [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #typechecking }
ViennaMapRangeNode >> returnTypeFor: aViennaType [

	^ aViennaType valuetype set
]
