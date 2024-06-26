Class {
	#name : 'ViennaSequenceTailNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaSequenceTailNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'tl'
]

{ #category : 'testing' }
ViennaSequenceTailNode >> isViennaSequenceTailNode [

	^ true
]

{ #category : 'accessing' }
ViennaSequenceTailNode >> label [

	^ 'SequenceTail'
]

{ #category : 'pretty printing' }
ViennaSequenceTailNode >> operatorPrecedence [

	^ 36
]

{ #category : 'typechecking' }
ViennaSequenceTailNode >> paramType [

	^ ViennaType any seq1
]

{ #category : 'typechecking' }
ViennaSequenceTailNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype seq
]
