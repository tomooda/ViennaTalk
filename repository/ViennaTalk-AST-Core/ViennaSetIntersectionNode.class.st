Class {
	#name : 'ViennaSetIntersectionNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaSetIntersectionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter inter
]

{ #category : 'accessing' }
ViennaSetIntersectionNode >> isViennaSetIntersectionNode [

	^ true
]

{ #category : 'accessing' }
ViennaSetIntersectionNode >> label [

	^ 'SetIntersection'
]

{ #category : 'pretty printing' }
ViennaSetIntersectionNode >> operatorPrecedence [

	^ 32
]

{ #category : 'accessing' }
ViennaSetIntersectionNode >> paramType1 [

	^ ViennaType any set
]

{ #category : 'accessing' }
ViennaSetIntersectionNode >> paramType2 [

	^ ViennaType any set
]

{ #category : 'accessing' }
ViennaSetIntersectionNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 basetype isCompatibleWith: aViennaType2 basetype)
		  ifTrue: [
			  (aViennaType1 basetype >= aViennaType2 basetype
				   ifTrue: [ aViennaType2 basetype ]
				   ifFalse: [ aViennaType1 basetype ]) set ]
		  ifFalse: [ ViennaTypeError signalOn: self ]
]
