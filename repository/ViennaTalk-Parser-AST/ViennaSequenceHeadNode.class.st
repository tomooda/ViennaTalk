Class {
	#name : #ViennaSequenceHeadNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceHeadNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'hd'
]

{ #category : #accessing }
ViennaSequenceHeadNode >> isViennaSequenceHeadNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceHeadNode >> label [

	^ 'SequenceHead'
]

{ #category : #'pretty printing' }
ViennaSequenceHeadNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaSequenceHeadNode >> paramType [

	^ ViennaType any seq1
]

{ #category : #typechecking }
ViennaSequenceHeadNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype
]
