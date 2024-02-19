Class {
	#name : #ViennaSequenceElementsNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceElementsNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'elems'
]

{ #category : #testing }
ViennaSequenceElementsNode >> isViennaSequenceElementsNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceElementsNode >> label [

	^ 'SequenceElements'
]

{ #category : #'pretty printing' }
ViennaSequenceElementsNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaSequenceElementsNode >> paramType [

	^ ViennaType any seq
]

{ #category : #typechecking }
ViennaSequenceElementsNode >> returnTypeFor: aViennaType [

	^ aViennaType isSeq1Type
		  ifTrue: [ aViennaType basetype set1 ]
		  ifFalse: [ aViennaType basetype set ]
]
